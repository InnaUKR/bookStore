require 'rails_helper'

feature 'User sign in', %q{

} do
  scenario 'Registered user try to sign in' do
    User.create!(email: 'user@test.com', password: '123456')

    visit new_user_session_path
    fill_in 'Enter Email', with: 'user@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Back to Store'

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Enter Email', with: 'wrong@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Back to Store'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end