require 'rails_helper'

feature 'checkout guest', %q{
  Given The user is a guest
  And he is at the Cart page,
  When he wants to check out his order
  And he clicks the Checkout button,
  Then he will be transferred to the Checkout Login page.
} do
  before do
    guest = create(:user, :guest)
    @line_item = create(:line_item, order: create(:order, user: guest))
  end
  scenario 'Guest clicks Checkouts button and redirects to the Checkout Login page' do
    visit order_cart_path(@line_item.order)
    click_on('Checkout')
    expect(page).to have_current_path(new_user_session_path)
  end
end