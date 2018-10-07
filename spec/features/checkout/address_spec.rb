require 'rails_helper'

feature 'At the Checkout page, the Address tab' do
  context 'User fills billing address form' do
    given!(:line_item) { create(:line_item, order: (create(:order))) }
    given(:address) { create(:address) }
    given(:other_address) { create(:address) }
    scenario 'Then he clicks Use Billing Address checkbox and Save and Continue button.\
              And user will be transferred to the Delivery step.' do
      sign_in(line_item.order.user)
      visit edit_order_path(line_item.order)
      expect(page).to have_current_path('/checkouts/address')

      fill_billing_address_form(address)
      first("input[name='address[use_billing]']", visible: false).set "true"
      click_on 'Save And Continue'

      expect(page).to have_current_path('/checkouts/delivery')
    end
    scenario 'Then he fills Shipping address form and clicks Save and Continue button.\
              And user will be transferred to the Delivery step.' do
      sign_in(line_item.order.user)
      visit edit_order_path(line_item.order)
      expect(page).to have_current_path('/checkouts/address')

      fill_billing_address_form(address)
      fill_shipping_address_form(other_address)
      click_on 'Save And Continue'

      expect(page).to have_current_path('/checkouts/delivery')
    end

    scenario '(Without fills shipping form) User clicks Save and Continue button.\
              And user won\'t be transferred to the Delivery step.' do
      sign_in(line_item.order.user)
      visit edit_order_path(line_item.order)
      expect(page).to have_current_path('/checkouts/address')

      fill_billing_address_form(address)
      click_on 'Save And Continue'

      expect(page).to have_current_path('/checkouts/address')
      expect(find('#order_shipping_address')).to have_content('can\'t be blank, is invalid')
    end
  end
end