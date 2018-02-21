class LineItemDecorator < Draper::Decorator
  delegate_all

  def total_price
    price = quantity.to_f * book.price
    sprintf('%.2f', price)
  end

  def increment_quantity
    increment!(:quantity)
  end

end
