# frozen_string_literal: true

class AddBillingAddressToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :billing_address, foreign_key: { to_table: :addresses }
    add_reference :orders, :shipping_address, foreign_key: { to_table: :addresses }
  end
end
