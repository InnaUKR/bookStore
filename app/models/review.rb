class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :body, :mark, presence: true

  scope :approved_reviews, ->(book) { book.reviews.where('approve = true') }
end
