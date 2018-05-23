class RenaneColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :mark, :score
  end
end
