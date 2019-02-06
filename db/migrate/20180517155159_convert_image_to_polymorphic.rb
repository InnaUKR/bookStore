# frozen_string_literal: true

class ConvertImageToPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_index :images, :book_id
    rename_column :images, :book_id, :imageable_id
    add_index :images, :imageable_id

    add_column :images, :imageable_type, :string
    add_index :images, :imageable_type
  end
end
