class AddStringToComments < ActiveRecord::Migration[5.1]
  def change
  	add_column :comments, :rating, :string
  end
end
