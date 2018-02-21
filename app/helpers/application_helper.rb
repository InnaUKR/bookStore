module ApplicationHelper
  def show_price(price)
    number_to_currency(price, unit: '€')
  end
end
