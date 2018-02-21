class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart
  validates :quantity, only_integer: true, greater_than_or_equal_to: 1
end
