# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def total_price
    quantity * book.price
  end
end
