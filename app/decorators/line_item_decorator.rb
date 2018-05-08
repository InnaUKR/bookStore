class LineItemDecorator < Draper::Decorator
  delegate_all

  def total_price
    quantity.to_f * book.price
  end
=begin
  def increment_quantity
    increment!(:quantity)
  end
=end
end
