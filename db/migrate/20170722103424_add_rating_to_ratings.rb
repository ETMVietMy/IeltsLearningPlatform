class AddRatingToRatings < ActiveRecord::Migration[5.1]
  def change
  	add_column :ratings, :rating, :integer
  end
end
