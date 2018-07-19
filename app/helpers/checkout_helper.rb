module CheckoutHelper

  def payment
    if @order.credit_card
      @form = @order.credit_card
    elsif current_user.credit_cards.any?
      @form = current_user.credit_cards.last
    end
    @form
  end
end
