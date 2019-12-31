# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.references :book, index: true
      t.integer :mark

      t.timestamps
    end
  end
end
