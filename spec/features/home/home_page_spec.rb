require 'rails_helper'

feature 'Home page' do
  given(:book) { create(:book) }

  scenario 'User can see Latest books, Get Started, Best sellers blocks' do
    sign_in create(:user)
    visit root_path

    expect(page).to have_css('#slider')
    expect(page).to have_content 'Get Started'
    expect(page).to have_content 'Best Sellers'
  end

  scenario 'Guest can see Latest books, Get Started, Best sellers blocks' do
    visit root_path

    expect(page).to have_css('#slider')
    expect(page).to have_content 'Get Started'
    expect(page).to have_content 'Best Sellers'
  end
end