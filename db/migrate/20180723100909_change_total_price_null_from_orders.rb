class ChangeTotalPriceNullFromOrders < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:orders, :total_price, true)
  end
end
