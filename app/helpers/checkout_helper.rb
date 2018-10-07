module CheckoutHelper
  def address
    @form.billing_address = @order.billing_address if @order.billing_address
    @form.shipping_address = @order.shipping_address  if @order.shipping_address
    @form
  end

  def payment
    if @order.credit_card
      @form = @order.credit_card
    elsif current_user.credit_cards.any?
      @form = current_user.credit_cards.last
    end
    @form
  end

end
