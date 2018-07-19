class DeliveryForm < CheckoutForm
  attribute :delivery_id, Integer
  validates :delivery_id, presence: true

  def update!(order)
    order.update(delivery_id: delivery_id, total_price: order.total_price)
  end

end