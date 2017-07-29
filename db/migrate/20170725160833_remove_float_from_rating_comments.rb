class RemoveFloatFromRatingComments < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :rating, :float, :default => 0
  end
end
