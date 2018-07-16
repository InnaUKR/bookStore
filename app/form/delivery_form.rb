class DeliveryForm < CheckoutForm
  attribute :delivery_id, Integer
  validates :delivery_id, presence: true

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