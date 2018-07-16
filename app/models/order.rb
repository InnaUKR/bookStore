class Order < ApplicationRecord
  include AASM

  has_many :line_items, dependent: :destroy


  belongs_to :user
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  validates :state, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.0 }

  def add_book(line_item_params)
    current_item = line_items.find_by(book_id: line_item_params[:book_id])
    if current_item
      current_item.quantity += line_item_params[:quantity]
    else
      current_item = line_items.build(line_item_params)
    end
    current_item
  end

  def sub_total
    line_items.sum(&:total_price)
  end

  def coupon
    coupon_id ? Coupon.find(coupon_id).amount : 0
  end

  def order_total
    sum = sub_total
    sum -= coupon if coupon_id
    sum += delivery.price
    sum
  end

  aasm column: :state do
    state :filling, initial: true
    state :in_confirmation, after_enter: :send_confirmation
    state :in_processing
    state :in_delivery
    state :completed
    state :canceled

    event :confirm do
      transitions from: :filling, to: :in_confirmation
    end

    event :process do
      transitions from: :in_confirmation, to: :in_processing
    end

    event :deliver do
      transitions from: :in_processing, to: :in_delivery
    end

    event :'complete.html.haml.haml' do
      transitions from: :in_delivery, to: :completed
    end

    event :cancel do
      transitions from: %i[filling in_confirmation in_processing in_delivery completed], to: :canceled
    end
  end


end

