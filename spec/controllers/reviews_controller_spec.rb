require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:book) { create(:book) }

    context 'with valid attributes' do
      it 'saves the review' do
        expect { post :create, params: { review: attributes_for(:review), book_id: book } }.to change(book.reviews, :count).by(1)
      end
      it 'redirect to book show view' do
        post :create, params: { review: attributes_for(:review), book_id: book }
        expect(response).to redirect_to book_path(book)
      end

    end
    context 'with invalid attributes' do
      it 'does not save the review' do
        expect { post :create, params: { review: attributes_for(:invalid_review), book_id: book} }.to_not change(Review, :count)
      end
      it 'redirect to book show view' do
        post :create, params: { review: attributes_for(:invalid_review), book_id: book}
        expect(response).to redirect_to book_path(book)
      end
    end
  end
end
