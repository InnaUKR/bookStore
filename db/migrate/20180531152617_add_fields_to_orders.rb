# frozen_string_literal: true

class AddFieldsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :credit_card_id, :integer
    add_index :orders, :credit_card_id
  end
end
