# frozen_string_literal: true

class AddBiographyToAuthor < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :biography, :string
  end
end
