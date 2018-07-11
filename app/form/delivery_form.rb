class DeliveryForm < Rectify::Form
  attribute :delivery_id, Integer
  validates :delivery_id, presence: true

  def save
    if valid?
      update!
      true
    else
      false
    end
  end

  private

  def update!
    context.order.update(delivery_id: delivery_id, total_price: total_price)
  end

  def delivery_price
    Delivery.find(delivery_id).price
  end

  def total_price
    context.order.order_total + delivery_price
  end

end