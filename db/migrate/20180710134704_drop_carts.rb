class DropCarts < ActiveRecord::Migration[5.1]
  def up
    drop_table :carts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
