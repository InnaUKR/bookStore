class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity, null: false
      t.text :description
      t.date :year, null: false
      t.string :dimension, null: false
      t.string :material, null: false

      t.timestamps
    end
  end
end
