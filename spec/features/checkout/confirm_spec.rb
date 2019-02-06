# frozen_string_literal: true

require 'rails_helper'

feature 'At the Checkout page, the Confirm tab' do
  given(:line_item) { create(:line_item, order: create(:order, :confirm)) }
  given(:new_phone) { '+380965555555' }
  given(:new_exp_date) { '12/30' }
  scenario 'When a user needs to change the data at the Address tab.
            He clicks the Edit link. Then the user is redirected to the Address tab.
            He changes billing phone number and clicks Save And Continue button.
            Then he is redirected back to the Confirm tab.
            User sees new billing phone number' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/confirm')

    first(:xpath, "//a[@href='/checkouts/address']").click
    expect(find('#address_billing_address_form_phone').value).to eq(line_item.order.billing_address.phone)
    fill_in 'address_billing_address_form_phone', with: new_phone
    click_on 'Save And Continue'

    expect(page).to have_current_path('/checkouts/confirm')
    expect(page).to have_content(new_phone)
  end
  scenario 'When a user needs to change the data at the Payment tab.
            He clicks the Edit link. Then the user is redirected to the Payment tab.
            He changes MM / YY and clicks Save And Continue button.
            Then he is redirected back to the Confirm tab.
            User sees new  MM / YY' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/confirm')
    first(:xpath, "//a[@href='/checkouts/payment']").click

    expect(find('input#expDate').value).to eq(line_item.order.credit_card.exp_date)
    fill_in 'MM / YY', with: new_exp_date
    click_on 'Save And Continue'

    expect(page).to have_current_path('/checkouts/confirm')
    expect(page).to have_content(new_exp_date)
  end
end
