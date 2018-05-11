require 'rails_helper'

feature 'Create cart for logged in or a guest user', %q{
  Given The user is logged in or a guest
  When he wants to check his Cart
  Then he clicks the icon in top right corner
  And he will be transferred to the Cart page.
} do
  given(:user) { create(:user) }
  scenario 'Registered user try to go to cart' do
    sign_in(user)

    click_on(class: ['shop-link', 'pull-right', 'visible-xs'])

    expect(page).to have_content'Cart'
  end

  scenario 'Non-registered user try to go to cart' do
    visit root_path
    click_on(class: ['shop-link', 'pull-right', 'visible-xs'])

    expect(page).to have_content'Cart'
  end
end