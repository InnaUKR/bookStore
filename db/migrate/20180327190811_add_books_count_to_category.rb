class AddBooksCountToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :books_count, :integer, default: 0
  end
end
