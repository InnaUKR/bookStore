class Coupon < ApplicationRecord
  validates :name, :amount, presence: true
end
