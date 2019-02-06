# frozen_string_literal: true

require 'rails_helper'

feature 'checkout user', '
Given The user is logged in
And he is at the Cart page,
When he wants to check out his order
And he clicks the Checkout button,
Then he will be transferred to the Checkout page, the Addresses tab.
' do
  given(:line_item) { create(:line_item) }

  scenario 'User clicks Checkout button and redirects to Checkout page, the Addresses tab' do
    sign_in(line_item.order.user)
    visit order_cart_path(line_item.order)

    click_on('Checkout')
    expect(page).to have_current_path('/checkouts/address')
  end
end
