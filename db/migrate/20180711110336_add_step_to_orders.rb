# frozen_string_literal: true

class AddStepToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :step, :string
  end
end
