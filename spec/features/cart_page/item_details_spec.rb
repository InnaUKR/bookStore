# frozen_string_literal: true

require 'rails_helper'

feature 'item details', '
  In order to check the details of an item in the Cart
  As a user or as a guest
  I want to be able to click on the item and to be redirected to the Book View.
' do
  let!(:line_item) { create(:line_item) }

  scenario '' do
    visit order_cart_path(line_item.order)
    click_on(line_item.book.title.to_s)
    expect(page).to have_current_path(book_path(line_item.book))
  end
end
