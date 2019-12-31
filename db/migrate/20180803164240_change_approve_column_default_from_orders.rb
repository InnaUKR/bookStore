# frozen_string_literal: true

class ChangeApproveColumnDefaultFromOrders < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:reviews, :approve, 'unprocessed')
  end
end
