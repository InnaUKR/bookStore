class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.decimal :amount, null: false, precision: 3, scale: 2
      t.timestamps
    end
  end
end
