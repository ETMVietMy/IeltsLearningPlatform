class CreateWritings < ActiveRecord::Migration[5.1]
  def change
    create_table :writings do |t|
      t.text :task_description
      t.string :task_type
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :teacher_id
      t.string :status

      t.timestamps
    end
  end
end
