class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :cvv
      t.string :card_name
      t.string :exp_date
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
