# frozen_string_literal: true

require 'rails_helper'

feature 'Book', '
  In order to add a book to the cart
  As a user or as a guest
  I want to be able to choose quantity by clicking the ‘-’/‘+’ buttons and click the Add to Cart button
 ' do
  let!(:book) { create(:book) }
  scenario 'User chooses quantity and clicks the Add to Cart button' do
    sign_in(create(:user))
    visit book_path(book)

    find('a.input-link:eq(1)').click
    expect(page).to have_content 'The value of quantity must be greater than 0'

    find('a.input-link:eq(2)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(2)

    find('a.input-link:eq(2)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(3)

    find('a.input-link:eq(1)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(2)

    expect(first('span.shop-icon').find('span.shop-quantity').text.to_i).to eq(0)
    click_on('Add to Cart')
    expect(first('span.shop-icon').find('span.shop-quantity').text.to_i).to eq(2)
  end

  scenario 'Guest chooses quantity and clicks the Add to Cart button' do
    visit book_path(book)

    find('a.input-link:eq(1)').click
    expect(page).to have_content 'The value of quantity must be greater than 0'

    find('a.input-link:eq(2)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(2)

    find('a.input-link:eq(2)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(3)

    find('a.input-link:eq(1)').click
    expect(find('.form-control.quantity-input').value.to_i).to eq(2)

    expect(first('span.shop-icon').find('span.shop-quantity').text.to_i).to eq(0)
    click_on('Add to Cart')
    expect(first('span.shop-icon').find('span.shop-quantity').text.to_i).to eq(2)
  end
end
