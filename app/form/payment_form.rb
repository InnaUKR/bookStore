class PaymentForm < CheckoutForm
  attribute :number, String
  attribute :card_name, String
  attribute :cvv, Integer
  attribute :exp_date, String

  validates :number,
            presence: true,
            format: { with: /\A[\d ]\d+\z/ }
  validates :card_name,
            presence: true,
            length: { maximum: 50 },
            format: { with: /\A[a-z ]+\z/i,
                      message: 'can consist of English letters and spaces' }
  validates :exp_date,
            presence: true,
            format: { with: /\A(0[1-9])|1[0-2]\/\d{2}\z/,
                      message: 'month value can not be one digit' }
  validates :cvv,
            presence: true,
            length: { in: 3..4 },
            numericality: true


  def update!(order)
    credit_card = credit_card(order)
    order.update(credit_card_id: credit_card.id)
  end

  private

  def credit_card(order)
    card = CreditCard.find_by(number: number)
    if card
      card.update(card_name: card_name,
                  cvv: cvv,
                  exp_date: exp_date)
      card
    else
      return order.user.credit_cards.create(number: number, card_name: card_name,
                                     cvv: cvv,
                                     exp_date: exp_date)
    end
  end
end