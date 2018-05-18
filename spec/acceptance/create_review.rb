require 'rails_helper'

feature 'Write a Review', %q{
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
  given(:user) { create(:user) }
  given(:category) { create(:category) }
  given(:book) { create(:book, category_id: category.id) }

  given(:review) { create(:review) }
  scenario 'Logged in user creates review' do
    visit book_path(book)
    fill_in 'Your review', with: 'My review'
    fill_in 'Mark', with: '5'

    click_on 'Post'
    expect(current_path).to eq book_path(book)

  end
end