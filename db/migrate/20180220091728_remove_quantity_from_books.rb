class RemoveQuantityFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :quantity, :integer
  end
end
