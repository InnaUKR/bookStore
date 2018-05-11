require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe 'GET #show' do
    let(:category) { create(:category) }
    let(:book) { create(:book, category_id: category.id) }
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
end
