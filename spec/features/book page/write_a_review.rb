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
  #And his review is sent to the Admin panel, Reviews, the New tab.
} do
  given(:user) { create(:user) }
  given(:book) { create(:book) }

  scenario 'Logged in user creates review' do
    sign_in(user)
    visit book_path(book)

    select 5, from: 'review_score'
    fill_in 'review_title', with: 'Review title'
    fill_in 'review_text', with: 'Review text'

    click_on 'Post'
    expect(current_path).to eq book_path(book)
    expect(page).to have_content 'Thanks for Review. It will be published as soon as Admin will approve it.'
  end
end