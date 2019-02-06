# frozen_string_literal: true

class AddTitleToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :title, :string
  end
end
