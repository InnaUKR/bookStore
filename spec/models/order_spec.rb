require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, book: book) }
  let(:line_item_with_coupon) { create(:line_item, order: create(:order, :with_coupon), book: book) }
  let(:line_item_with_delivery) { create(:line_item, order: create(:order, :with_delivery), book: book) }
  let(:line_item_with_coupon_and_delivery) { create(:line_item, order: create(:order, :with_coupon, :with_delivery), book: book) }
  it { is_expected.to have_many(:line_items) }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :delivery }
  it { is_expected.to belong_to :credit_card }
  it { is_expected.to belong_to :billing_address }
  it { is_expected.to belong_to :shipping_address }

  context '#add_book' do
    subject(:order) { line_item.order }
    it 'returns line item' do
      expect(order.add_book(book_id: book.id, quantity: 3)).to eq(order.line_items.first)
    end

    it 'adds quantity to existing line item' do
      expect(order.add_book(book_id: book.id, quantity: 3).quantity).to eq(4)
    end

    it 'adds new line item to current order and set quantity' do
      expect(order.add_book(book_id: create(:book), quantity: 3).quantity).to eq(3)
    end
  end

  context '#order_total' do
    context 'without coupon and delivery' do
      subject { line_item.order.order_total }
      it { is_expected.to eq(book.price) }
    end

    context 'when order include few line items' do
      subject(:order) { line_item.order }
      it do
        create(:line_item, order_id: order.id, book: book)
        expect(order.order_total).to eq(book.price * 2)
      end
    end

    context 'with coupon' do
      subject(:order) { line_item_with_coupon.order }

      it { expect(order.order_total).to eq(book.price - order.coupon.amount) }
    end

    context 'with delivery' do
      subject(:order) { line_item_with_delivery.order }
      it { expect(order.order_total).to eq(book.price + order.delivery.price) }
    end

    context 'with coupon and delivery' do
      subject(:order) { line_item_with_coupon_and_delivery.order }
      it { expect(order.order_total).to eq(book.price - order.coupon.amount + order.delivery.price) }
    end
  end
end
