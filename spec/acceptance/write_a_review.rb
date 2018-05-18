require 'rails_helper'
include Warden::Test::Helpers

feature 'Write a review to book', %q{
  Given The user is logged in
  And he is at the Book view
  When he wants to leave a review about a book
  Then he scrolls down to the end of reviews to the Write a Review block,
  And he assigns a score,
  And enters a Title,
  And enters a text of review in the Review text box,
  And clicks the Post button,
  Then the user will see a message: ‘Thanks for Review. It will be published as soon as Admin will approve it.’
  And his review is sent to the Admin panel, Reviews, the New tab.
} do
  given(:category) { create(:category) }
  given(:user) { create(:user) }
  given(:book) { create(:book, category_id: category.id) }


  background do
    login_as(user)
    visit book_path(book)
  end

  scenario 'User write a review' do
    fill_in 'review_body', with: 'Text of review'
    fill_in 'Mark', with: '5'
    click_on 'Post'

    expect(page).to have_content 'Thanks for Review. It will be published as soon as Admin will approve it.'
  end
end