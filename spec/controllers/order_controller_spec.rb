require 'rails_helper'

RSpec.describe OrderController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:orders) { create(:orders, :with_order_items) }

    context 'with valid attributes' do
      it 'saves the review' do
        expect { post :create, params: { review: attributes_for(:review), book_id: book } }.to change(book.reviews, :count).by(1)
      end
      it 'redirect to book show view' do
        post :create, params: { review: attributes_for(:review), book_id: book }
        expect(response).to redirect_to book_path(book)
      end

    end
  end
end
