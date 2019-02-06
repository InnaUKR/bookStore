# frozen_string_literal: true

require 'rails_helper'

feature 'Settings#remove_account' do
  given(:user) { create(:user) }
  scenario 'User clicks the Please Remove My Account button' do
    sign_in(user)
    visit edit_user_path(user)
    click_on('Please Remove My Account')
    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end
end
