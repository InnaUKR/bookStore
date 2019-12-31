# frozen_string_literal: true

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

    context 'when quantity equal 0' do
      before { put :change_quantity, params: { book_id: book.to_param, quantity: 0 } }
      it 'show flash message' do
        expect(flash[:alert]).to eq(I18n.t('books.change_quantity.quantity_eq_0'))
      end

      it 'redirects to book page' do
        is_expected.to redirect_to(book)
      end
    end

    it 'assigns item quantity' do
      put :change_quantity, params: { book_id: book.to_param, quantity: 3 }
      expect(assigns(:item).quantity).to eq(3)
    end
  end
end
