class RemoveRatingsFromComments < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :rating, :integer
  end
end
