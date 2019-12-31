# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all

  def coupon
    coupon_id ? Coupon.find(coupon_id).amount : 0
  end

  def number
    'R' + '0' * (8 - id.to_s.length) + id.to_s
  end

  def date
    created_at.strftime('%b %d %Y')
  end

  def status
    state.capitalize
  end
end
