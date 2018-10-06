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

      fill_in 'address_billing_address_form_first_name', with: address.first_name
      fill_in 'address_billing_address_form_last_name', with: address.last_name
      fill_in 'address_billing_address_form_address', with: address.address
      fill_in 'address_billing_address_form_city', with: address.city
      fill_in 'address_billing_address_form_zip', with: address.zip
      fill_in 'address_billing_address_form_country', with: address.country
      fill_in 'address_billing_address_form_phone', with: address.phone
      first("input[name='address[use_billing]']", visible: false).set "true"
      click_on 'Save And Continue'

      expect(page).to have_current_path('/checkouts/delivery')
    end
    scenario 'Then he fills Shipping address form and clicks Save and Continue button.\
              And user will be transferred to the Delivery step.' do
      sign_in(line_item.order.user)
      visit edit_order_path(line_item.order)
      expect(page).to have_current_path('/checkouts/address')

      fill_in 'address_billing_address_form_first_name', with: address.first_name
      fill_in 'address_billing_address_form_last_name', with: address.last_name
      fill_in 'address_billing_address_form_address', with: address.address
      fill_in 'address_billing_address_form_city', with: address.city
      fill_in 'address_billing_address_form_zip', with: address.zip
      fill_in 'address_billing_address_form_country', with: address.country
      fill_in 'address_billing_address_form_phone', with: address.phone

      fill_in 'address_shipping_address_form_first_name', with: other_address.first_name
      fill_in 'address_shipping_address_form_last_name', with: other_address.last_name
      fill_in 'address_shipping_address_form_address', with: other_address.address
      fill_in 'address_shipping_address_form_city', with: other_address.city
      fill_in 'address_shipping_address_form_zip', with: other_address.zip
      fill_in 'address_shipping_address_form_country', with: other_address.country
      fill_in 'address_shipping_address_form_phone', with: other_address.phone

      click_on 'Save And Continue'
      expect(page).to have_current_path('/checkouts/delivery')
    end

    scenario '(Without fills shipping form) User clicks Save and Continue button.\
              And user won\'t be transferred to the Delivery step.' do
      sign_in(line_item.order.user)
      visit edit_order_path(line_item.order)
      expect(page).to have_current_path('/checkouts/address')

      fill_in 'address_billing_address_form_first_name', with: address.first_name
      fill_in 'address_billing_address_form_last_name', with: address.last_name
      fill_in 'address_billing_address_form_address', with: address.address
      fill_in 'address_billing_address_form_city', with: address.city
      fill_in 'address_billing_address_form_zip', with: address.zip
      fill_in 'address_billing_address_form_country', with: address.country
      fill_in 'address_billing_address_form_phone', with: address.phone

      click_on 'Save And Continue'
      expect(page).to have_current_path('/checkouts/address')
      expect(find('#order_shipping_address')).to have_content('can\'t be blank, is invalid')
    end
  end
end