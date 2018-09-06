class Review < ApplicationRecord
  include AASM
  CHARACTERS = "\\-!#\\$%&'\\*\\+\\/=\\?\\^_`{|}~\\."

  belongs_to :book
  belongs_to :user
  validates :score, presence: true
  validates :title,
            presence: true,
            format: { with: /\A[a-z\d#{CHARACTERS} ]+\z/i },
            length: { maximum: 80 }
  validates :text,
            presence: true,
            format: { with: /\A[a-z\d#{CHARACTERS} ]+\z/i },
            length: { maximum: 500 }

  scope :approved_reviews, ->(book) { book.reviews.where(state: 'approved') }
  scope :new_reviews, -> { where state: 'unprocessed' }
  scope :processed, -> { where('state=? OR state=?', 'approved', 'rejected') }

  aasm column: :state do
    state :unprocessed, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end
  end

end
