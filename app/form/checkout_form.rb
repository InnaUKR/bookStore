# frozen_string_literal: true

class CheckoutForm < Rectify::Form
  def save
    if valid?
      true
    else
      false
    end
  end
end
