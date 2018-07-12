class PaymentForm < Rectify::Form
  attribute :number, String
  attribute :card_name, String
  attribute :cvv, Integer
  attribute :exp_date, String

  validates :number, presence: true,
            format: { with: /\A[0-9]\d+/ }, length: { maximum: 16 }
  validates :cvv, presence: true,
            length: { in: 3..4 },
            numericality: true
  validates :card_name, presence: true,
            length: { maximum: 50 },
            format: { with: /\A[a-zа-я\s]+\z/i }
  validates :exp_date, presence: true,
            length: { maximum: 5 }

  def save
    if valid?
      update!
      true
    else
      false
    end
  end

  private

  def update!
    context.order.update(step: context.step)
    context.order.update(credit_card_id: credit_card)
  end

  def credit_card
    card1 = CreditCard.find_by(number: number)
    card2 = context.user.credit_cards.create(number: number,
                                             card_name: card_name,
                                             cvv: cvv,
                                             exp_date: exp_date)
    card1 || card2
  end
end