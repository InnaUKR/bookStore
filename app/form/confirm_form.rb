class ConfirmForm < CheckoutForm

  def update!(order)
    order.update(delivery_id: delivery_id, total_price: total_price(order))
  end

  private

  def delivery_price
    Delivery.find(delivery_id).price
  end

  def total_price(order)
    order.order_total
  end
end