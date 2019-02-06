# frozen_string_literal: true

class FixColumnNameInReview < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :reviews, :body, :text
  end

  def self.down
    rename_column :reviews, :text, :body
  end
end
