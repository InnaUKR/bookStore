# frozen_string_literal: true

require 'rails_helper'

feature 'checkout guest', '
  Given The user is a guest
  And he is at the Cart page,
  When he wants to check out his order
  And he clicks the Checkout button,
  Then he will be transferred to the Checkout Login page.
' do
  before do
    guest = create(:user, :guest)
    @line_item = create(:line_item, order: create(:order, user: guest))
  end
  scenario 'Guest clicks Checkouts button and redirects to the Checkout Login page' do
    visit order_cart_path(@line_item.order)
    click_on('Checkout')
    expect(page).to have_content('You are not authorized to access this page.')
  end
end
