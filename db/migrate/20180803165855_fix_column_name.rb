# frozen_string_literal: true

class FixColumnName < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :reviews, :approve, :state
  end

  def self.down
    rename_column :reviews, :state, :approve
  end
end
