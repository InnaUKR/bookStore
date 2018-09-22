require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:line_item) { create(:line_item) }
  describe 'PUT #down_quantity' do
    context 'when quantity equal 1' do
      before { put :down_quantity, params: { line_item_id: line_item.id } }
      it 'does not change quantity ' do
        expect(line_item.reload.quantity).to eq(1)
      end
      it { is_expected.to redirect_to "/orders/#{line_item.order.id}/cart" }
    end

    context 'when quantity greater than 1' do
      let(:line_item) { create(:line_item, quantity: 5) }
      before { put :down_quantity, params: { line_item_id: line_item.id } }
      it 'decrements quantity' do
        expect(line_item.reload.quantity).to eq(4)
      end
      it { is_expected.to redirect_to "/orders/#{line_item.order.id}/cart" }
    end
  end

  describe 'PUT #up_quantity' do
    before {put :up_quantity, params: { line_item_id: line_item.id } }
    it { is_expected.to redirect_to "/orders/#{line_item.order.id}/cart" }
    it { expect(line_item.reload.quantity).to eq(2) }
  end
end