require 'rails_helper'

feature 'Latest books', %{
  In order to add book to the cart
  As a guest or as a user
  I want to be able to click the Buy Now link} do
  before { create_list(:book, 3) }

  scenario 'User clicks the Buy Now' do
    sign_in create(:user)
    visit root_path
    within('div.item.active') do
      click_link 'Buy Now'
    end

    expect(page).to have_current_path "/orders/#{Order.last.id}/cart"
    expect(page).to have_content('Book was successfully added to cart')
  end

  scenario 'Guest clicks the Buy Now' do
    visit root_path
    within('div.item.active') do
      click_link 'Buy Now'
    end

    expect(page).to have_current_path "/orders/#{Order.last.id}/cart"
    expect(page).to have_content('Book was successfully added to cart')
  end
end