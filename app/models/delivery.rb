class Delivery < ApplicationRecord
  has_many :orders
  validates :method_name, presence: true
  validates :days, numericality: { presence: true }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end