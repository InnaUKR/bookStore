class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :score, presence: true
  validates :body,
            presence: true,
            numericality: { less_than: 500 }

  scope :approved_reviews, ->(book) { book.reviews.where('approve = true') }
end
