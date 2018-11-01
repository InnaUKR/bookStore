module CheckoutHelper
  def address
    if @order.billing_address
      @form.billing_address = @order.billing_address
    elsif current_user.addresses.where(billing: true)
      @form.billing_address = current_user.addresses.where(billing: true)
    end
    if @order.shipping_address
      @form.shipping_address = @order.shipping_address
    elsif current_user.addresses.where(shipping: true)
      @form.shipping_address = current_user.addresses.where(shipping: true)
    end
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
