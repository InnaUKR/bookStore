require 'rails_helper'

feature 'Cart #transfer_to_cart_page', %q{
  In order to check your Cart
  As a user or as guest
  I want to be able to click the icon in top right corner
} do
  scenario do
    visit root_path
    find('a.shop-link.pull-right.hidden-xs').click
    expect(page).to have_current_path('/orders/1/cart')
  end
end