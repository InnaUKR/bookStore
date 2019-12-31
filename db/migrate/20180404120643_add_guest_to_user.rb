# frozen_string_literal: true

class AddGuestToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :guest, :boolean
  end
end
