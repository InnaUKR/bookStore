class CartDecorator < Draper::Decorator
  delegate_all

  def total_price
    LineItemDecorator.decorate_collection(line_items).to_a.sum(&:total_price)
  end

  def price_with_coupon(coupon_price)
    total_price.to_f - coupon_price
  end

end
