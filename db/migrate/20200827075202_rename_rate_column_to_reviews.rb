class RenameRateColumnToReviews < ActiveRecord::Migration[5.2]
  def change
  	rename_column :reviews, :rate, :rank
  end
end
