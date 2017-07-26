class AddRatingsToComments < ActiveRecord::Migration[5.1]
  def change
  	add_column :comments, :rating, :float, :default => 0
  end
end
