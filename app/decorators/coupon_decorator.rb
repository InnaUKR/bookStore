class CouponDecorator < Draper::Decorator
  delegate_all

  def price
    amount ? amount : 0
  end
end