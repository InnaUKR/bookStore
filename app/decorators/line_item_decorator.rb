# frozen_string_literal: true

class LineItemDecorator < Draper::Decorator
  delegate_all

  def total_price
    quantity.to_f * book.price
  end
end
