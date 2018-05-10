require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe 'POST #update' do
    let(:category) { create(:category) }
    let(:book) { create(:book, category_id: category.id) }
    context 'with valid attributes' do
      it 'save the new book in the database' do

      end
      it 'redirects to show view' do
        #patch :update, params: { id: book, book: {title: 'ghjg'}}
      end
    end
  end
end