require 'rails_helper'

feature 'At the Checkout page, the Complete tab' do
  given(:line_item) { create(:line_item, order: create(:order, :complete)) }
  scenario 'A user can check all displayed information,
            Then the user can click the Back to Store button,
            And he will be transferred to the Catalog page.' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/complete')
    click_on('Back to Store')
    expect(page).to have_current_path('/categories')
    expect(page).to have_content('Catalog')
  end
end