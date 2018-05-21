class AddColumnToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :approve, :boolean, default: false
  end
end
