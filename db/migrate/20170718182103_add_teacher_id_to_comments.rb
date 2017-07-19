class AddTeacherIdToComments < ActiveRecord::Migration[5.1]
  def change
  	add_column :comments, :teacher_id, :integer
  end
end
