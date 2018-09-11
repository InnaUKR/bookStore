require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe '#create' do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    context 'authenticated user' do
      before do
        sign_in(create(:user))
      end

      context 'with valid attributes' do
        it 'adds a review' do
          expect {
            post :create, params: { review: attributes_for(:review, user_id: user), book_id: book }
          }.to change(Review.all, :count).by(1)
        end

        it 'redirects to the book page' do
          post :create, params: { review: attributes_for(:review), book_id: book }
          expect(response).to redirect_to book_path(book)
        end

        it'shows flash message' do
          post :create, params: { review: attributes_for(:review), book_id: book }
          expect(flash[:notice]).to eq 'Thanks for Review. It will be published as soon as Admin will approve it.'
        end
      end

      context 'with invalid attributes' do
        it 'does not add a review' do
          expect {
            post :create, params: { review: attributes_for(:invalid_review), book_id: book }
          }.to change(Review.all, :count).by(0)
        end

        it 'redirects to the book page' do
          post :create, params: { review: attributes_for(:invalid_review), book_id: book }
          expect(response).to redirect_to book_path(book, review: attributes_for(:invalid_review, book_id: book))
        end
      end
    end

    context 'as a guest' do
      it 'returns a 302 response' do
        post :create, params: { review: attributes_for(:review), book_id: book }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the root page' do
        post :create, params: { review: attributes_for(:review), book_id: book }
        expect(response).to redirect_to root_path
      end

      it 'does not add a review' do
        expect {
          post :create, params: { review: attributes_for(:review, user_id: user), book_id: book }
        }.to change(Review.all, :count).by(0)
      end
    end
  end
end
