class AddTeacherIdToRatings < ActiveRecord::Migration[5.1]
  def change
  	add_column :ratings, :teacher_id, :integer
  end
end
