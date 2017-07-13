class AddInfoToTasks < ActiveRecord::Migration[5.1]
  def change
  	add_column :tasks, :description, :text
  	add_column :tasks, :task_number, :integer
  end
end
