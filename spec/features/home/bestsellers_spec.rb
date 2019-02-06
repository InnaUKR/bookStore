# frozen_string_literal: true

require 'rails_helper'

feature 'Bestsellers', '
  In order to see the details of the item
  As a guest or as a user
  I want to be able to click the View icon
 ' do
  before { allow(Book).to receive(:best_sellers).and_return(create_list(:book, 4)) }

  scenario 'Guest clicks the View icon' do
    visit root_path

    first('a.thumb-hover-link').click
    expect(page).to have_current_path '/books/1'
  end

  scenario 'User clicks the View icon' do
    sign_in create(:user)
    visit root_path

    first('a.thumb-hover-link').click
    expect(page).to have_current_path '/books/1'
  end
end
