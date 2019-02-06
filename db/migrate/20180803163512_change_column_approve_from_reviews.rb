# frozen_string_literal: true

class ChangeColumnApproveFromReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :approve, :string
  end
end
