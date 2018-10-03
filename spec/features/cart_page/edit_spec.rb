require 'rails_helper'

feature 'edit cart', %q{
  Given The user is logged in or a guest
  And he is at the Cart page,
  When he wants to change the quantity of products in the cart,
  And he clicks the ‘-’/‘+’ buttons (default value=1, increment=1),
  Then quantity of the product will be changed.
  When he wants to delete a product from the cart,
  And he clicks the Cross icon against the product
  Then the item will be deleted from the Cart.} do
  given(:line_item) { create(:line_item, quantity: 2, order: create(:order, user: create(:user, :guest))) }
  scenario 'decrements the quantity of products in the cart' do
    visit order_cart_path(line_item.order)

    expect {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('a.input-link:eq(1)').click
      end
    }.to (change {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('.form-control.quantity-input').value
      end
    }).from('2').to('1')

    expect {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('a.input-link:eq(1)').click
      end
    }.to_not (change {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('.form-control.quantity-input').value
      end
    })

    expect(page).to have_content('Quantity can not be less than 1. Use X button if you want delete')
  end

  scenario 'increments the quantity of products in the cart' do
    visit order_cart_path(line_item.order)

    expect {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('a.input-link:eq(2)').click
      end
    }.to (change {
      within 'div.general-cart-item.divider-lg-bottom' do
        find('.form-control.quantity-input').value
      end
    }).from('2').to('3')
  end

  scenario 'delete a product from the cart' do
    visit order_cart_path(line_item.order)
    book_title = line_item.book.title
    within 'div.general-cart-item.divider-lg-bottom' do
      expect(find('p.title').text).to have_content(book_title)
      find('a.close.general-cart-close').click
    end
    expect(page).to_not have_content(book_title)
    expect(page).to have_content('Book item was successfully deleted from the cart')
  end
end