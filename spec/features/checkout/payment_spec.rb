# frozen_string_literal: true

require 'rails_helper'

feature 'At the Checkout page, the Payment tab' do
  given(:line_item) { create(:line_item, order: create(:order, :payment)) }
  given(:card) { create(:credit_card, user: line_item.order.user) }
  scenario 'User fills in all fields and clicks the Save and Continue button/
             And user will be transferred to the Confirm step.' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/payment')

    fill_in 'Card Number', with: card.number
    fill_in 'Name on Card', with: card.card_name
    fill_in 'MM / YY', with: card.exp_date
    fill_in 'CVV', with: card.cvv
    click_on 'Save And Continue'

    expect(page).to have_current_path('/checkouts/confirm')
  end

  scenario 'User fills in NOT all fields and clicks the Save and Continue button/
             User wont be transferred to the Confirm step.' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/payment')

    fill_in 'Card Number', with: card.number
    fill_in 'CVV', with: card.cvv
    click_on 'Save And Continue'

    expect(page).to have_current_path('/checkouts/payment')
  end
end
