class Order < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :delivery
  validates :state, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }

  aasm column: :state do
    state :filling, initial: true
    state :in_confirmation, after_enter: :send_confirmation
    state :in_processing
    state :in_delivery
    state :completed
    state :canceled

    event :confirm do
      transitions from: :filling, to: :in_confirmation
    end

    event :process do
      transitions from: :in_confirmation, to: :in_processing
    end

    event :deliver do
      transitions from: :in_processing, to: :in_delivery
    end

    event :'complete.html.haml.haml' do
      transitions from: :in_delivery, to: :completed
    end

    event :cancel do
      transitions from: %i[filling in_confirmation in_processing in_delivery completed], to: :canceled
    end
  end


end

