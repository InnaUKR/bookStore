module FeatureHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Enter Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Back to Store'
  end

  def fill_billing_address_form(address)
    fill_in 'address_billing_address_form_first_name', with: address.first_name
    fill_in 'address_billing_address_form_last_name', with: address.last_name
    fill_in 'address_billing_address_form_address', with: address.address
    fill_in 'address_billing_address_form_city', with: address.city
    fill_in 'address_billing_address_form_zip', with: address.zip
    fill_in 'address_billing_address_form_country', with: address.country
    fill_in 'address_billing_address_form_phone', with: address.phone
  end

  def fill_shipping_address_form(address)
    fill_in 'address_shipping_address_form_first_name', with: address.first_name
    fill_in 'address_shipping_address_form_last_name', with: address.last_name
    fill_in 'address_shipping_address_form_address', with: address.address
    fill_in 'address_shipping_address_form_city', with: address.city
    fill_in 'address_shipping_address_form_zip', with: address.zip
    fill_in 'address_shipping_address_form_country', with: address.country
    fill_in 'address_shipping_address_form_phone', with: address.phone
  end
end
