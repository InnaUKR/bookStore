# frozen_string_literal: true

module ApplicationHelper
  def show_price(price)
    number_to_currency(price, unit: '€')
  end

  def categories
    Category.all
  end

  def deliveries
    Delivery.all
  end

  def books_in_curt
    current_order.line_items.sum(&:quantity)
  end
end
