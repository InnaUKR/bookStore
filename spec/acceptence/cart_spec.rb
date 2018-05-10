require 'rails_helper'

feature 'Create cart for logged in or a guest user', %q{
  Given The user is logged in or a guest
  When he wants to check his Cart
  Then he clicks the icon in top right corner
  And he will be transferred to the Cart page.
} do
  scenario 'Registered user try to go to cart' do
    User.create!(email: 'user@test.com', password: '123456')

    visit new_user_session_path
    fill_in 'Enter Email', with: 'user@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Back to Store'

    find_link(class: ['shop-link', 'pull-right', 'visible-xs'], :visible => :all).click

    expect(page).to have_content'Cart'
  end

  scenario 'Non-registered user try to go to cart' do
    visit root_path
    find_link(class: ['shop-link', 'pull-right', 'visible-xs'], :visible => :all).click

    expect(page).to have_content'Cart'
  end
end