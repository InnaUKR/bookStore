class PaymentForm < CheckoutForm
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

  def update!(order)
    credit_card = credit_card(order)
    order.update(credit_card_id: credit_card.id)
  end

  private

  def credit_card(order)
    CreditCard.find_by(number: number) || order.user.credit_cards.create(number: number,
                                              card_name: card_name,
                                             cvv: cvv,
                                             exp_date: exp_date)
  end
end