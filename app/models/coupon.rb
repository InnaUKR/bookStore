class Coupon < ApplicationRecord
  has_many :orders
  validates :name, :amount, presence: true
end
