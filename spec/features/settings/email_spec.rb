require 'rails_helper'

RSpec.feature 'Settings#email' do
  given(:email) { 'email@test.com' }
  given(:user) { create(:user, email: email) }
  given(:new_valid_email) { 'newemail@test.com' }
  given(:new_invalid_email) { 'new..invalid@test!' }

  scenario 'Registered user successfully changes password' do
    sign_in(user)
    visit edit_user_path(user)
    fill_in 'email', with: new_valid_email
    find("#save_email_btn").click
    expect(page).to have_field("email", placeholder: 'Enter your new email. Current email ' + new_valid_email)
  end

  scenario 'Registered user successfully changes password' do
    sign_in(user)
    visit edit_user_path(user)
    fill_in 'email', with: new_invalid_email
    find("#save_email_btn").click
    expect(find('form.email_form')).to have_content('incorrect format')
  end
end
