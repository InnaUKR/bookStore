module CheckoutHelper
  def payment
    if @order.credit_card_id
      @form.from_params(@order.credit_card.attributes)
    elsif current_user.credit_cards.any?
      @form.from_params(current_user.credit_cards.last.attributes)
    end
    @form
  end
end
