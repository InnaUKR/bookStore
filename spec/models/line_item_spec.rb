require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:book) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1) }

  context '#total_price' do
    it 'when quantity equal one' do
      expect(create(:line_item, book: create(:book, price: 10)).total_price).to eq(10)
    end

    it 'when quantity greater than one' do
      expect(create(:line_item, quantity: 10, book: create(:book, price: 10)).total_price).to eq(100)
    end
  end
end
