class RemoveStringFromRatingComment < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :rating, :string
  end
end
