class ConfirmForm < CheckoutForm
  def update!(order)
    order.update(delivery_id: delivery_id, total_price: order.total_price)
  end
end