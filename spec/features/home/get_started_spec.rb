# frozen_string_literal: true

require 'rails_helper'

feature 'get started', "
  In order to be transferred to the Catalog page'
  As a guest or as a user
  I want to be able to click the Get Started
 " do
  scenario 'User clicks Get Started' do
    sign_in create(:user)
    visit root_path
    click_on 'Get Started'

    expect(page).to have_content('Catalog')
    expect(current_path).to eq categories_path
  end

  scenario 'Guest clicks Get Started' do
    visit root_path
    click_on 'Get Started'

    expect(page).to have_content('Catalog')
    expect(current_path).to eq categories_path
  end
end
