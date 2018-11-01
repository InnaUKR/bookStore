require 'rails_helper'

feature 'Settings#update_password' do
  given(:password) { 'Password1' }
  given(:user) { create(:user, password: password) }
  given(:new_valid_password) { 'Password2' }
  given(:new_invalid_password) { 'InvalidPassword' }

  scenario 'Registered user successfully changes password' do
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'user_current_password', with: password
    fill_in 'user_password',               with: new_valid_password
    fill_in 'user_password_confirmation',  with: new_valid_password
    click_on 'Update'
    expect(user.reload.valid_password?(new_valid_password)).to be true
  end

  scenario 'Registered user trys to change current password to invalid and input password confirmation' do
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'user_current_password', with: 'Wrong' + password
    click_on 'Update'
    expect(page).to have_css('div.user_current_password.has-error')
    expect(find('div.user_current_password.has-error')).to have_content 'is invalid'
  end

  scenario 'Registered user tries to change current password to invalid
            and inputs password confirmation that doesn\'t match new password' do
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'user_current_password', with: password
    fill_in 'user_password',               with: new_invalid_password
    fill_in 'user_password_confirmation',  with: new_invalid_password + 'something randomly pressed'
    click_on 'Update'
    expect(page).to have_css('div.user_password.has-error')
    expect(find('div.user_password')).to have_content 'should contain at least 1 uppercase, 1 lowercase and 1 number'
    expect(page).to have_css('div.user_password_confirmation.has-error')
    expect(find('div.user_password_confirmation')).to have_content 'doesn\'t match Password'
  end

  scenario 'Registered user tries to change current password to invalid
            and inputs password confirmation that match new password' do
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'user_current_password', with: password
    fill_in 'user_password',               with: new_invalid_password
    fill_in 'user_password_confirmation',  with: new_invalid_password
    click_on 'Update'
    expect(page).to have_css('div.user_password.has-error')
    expect(find('div.user_password')).to have_content 'should contain at least 1 uppercase, 1 lowercase and 1 number'
    expect(page).to_not have_css('div.user_password_confirmation.has-error')
  end
end
