class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.references :delivery, foreign_key: true
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.string :state

      t.timestamps
    end
  end
end
