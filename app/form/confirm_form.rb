class ConfirmForm < CheckoutForm
  def update!(order)
    order.update(total_price: order.total_price, state: 'in_queue')
  end
end