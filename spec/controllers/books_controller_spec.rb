require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do
    let(:book) { create(:book) }
    before { get :show, params: { id: book.to_param } }

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq book
    end

    it 'assigns new review for book' do
      expect(assigns(:review)).to be_a_new(Review)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'PUT #change_quantity' do
    let(:book) { create(:book) }

    it 'renders show view when quantity more or equal to 1' do
      put :change_quantity, params: { book_id: book.to_param, quantity: 1 }
      expect(response).to render_template :show
    end

    it 'redirects to book page when quantity less than 1' do
      put :change_quantity, params: { book_id: book.to_param, quantity: 0 }
      expect(response).to redirect_to(book)
    end

    it 'assigns item quantity' do
      put :change_quantity, params: { book_id: book.to_param, quantity: 3 }
      expect(assigns(:item).quantity).to eq(3)
    end
  end
end