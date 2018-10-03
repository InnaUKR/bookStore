require 'rails_helper'

feature 'coupon', %q{
  Given The user is logged in or a guest
  And he is at the Cart page
  When he wants to use a coupon
  And he enters coupon code in the Enter Your Coupon Code field
  And clicks the Update Cart button
  Then the amount of discount will be displayed in the Coupon amount in Order Summary
  And will be deducted from the Order Total amount.
} do
  given(:line_item) { create(:line_item, order: create(:order, user: create(:user, :guest))) }
  given(:coupon) { create(:coupon) }

  scenario '' do
    visit order_cart_path(line_item.order)
    fill_in 'Enter Your Coupon Code', with: coupon.name
    within 'table.general-summary-table.general-summary-table-right.general-text-right' do
      expect(last('td').text).to eq(line_item.book.price - coupon.amount)
    end
  end
end