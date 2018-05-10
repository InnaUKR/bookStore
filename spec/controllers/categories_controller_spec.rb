require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new book in the database' do
        category = create(:category)
      end
      it 'redirects to show view'
    end
  end
end