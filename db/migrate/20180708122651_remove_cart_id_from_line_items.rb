# frozen_string_literal: true

class RemoveCartIdFromLineItems < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :line_items, :carts
  end
end
