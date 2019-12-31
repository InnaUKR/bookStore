# frozen_string_literal: true

class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :height, :decimal, precision: 5, scale: 2
    add_column :books, :width, :decimal, precision: 5, scale: 2
    add_column :books, :depth, :decimal, precision: 5, scale: 2
  end
end
