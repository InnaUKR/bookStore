class Review < ApplicationRecord
  belongs_to :book
  validates :body, :mark, presence: true
end
