class RenameColumnYearTableBook < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :year, :date_of_publication
  end
end
