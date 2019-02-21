# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM
  has_many :line_items, dependent: :destroy

  belongs_to :user
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true
  belongs_to :coupon, optional: true

  default_scope { order(created_at: :desc) }

  scope :in_progress, -> { Order.where(state: 'in_progress') }
  scope :in_queue, -> { where state: 'in_queue' }
  scope :in_delivery, -> { where state: 'in_delivery' }
  scope :delivered, -> { where state: 'delivered' }
  scope :canceled, -> { where state: 'canceled' }
  scope :in_progress_admin, lambda {
    where('state=? OR state=? OR state=?',
          'in_progress', 'in_queue', 'in_delivery')
  }

  def add_book(line_item_params)
    current_item = line_items.find_by(book_id: line_item_params[:book_id])
    if current_item
      current_item.quantity += line_item_params[:quantity].to_i
    else
      current_item = line_items.build(line_item_params)
    end
    current_item
  end

  def order_total
    sum = sub_total
    sum -= coupon.amount if coupon
    sum += delivery.price if delivery
    sum
  end

  def sub_total
    line_items.sum(&:total_price)
  end

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :to_queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :process do
      transitions from: :in_queue, to: :in_delivery
    end

    event :deliver do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: %i[filling in_progress in_queue in_delivery elivered completed], to: :canceled
    end
  end
end
