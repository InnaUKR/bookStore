# frozen_string_literal: true

class AddBookIdToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :book_id, :integer
    add_index :images, :book_id
  end
end
