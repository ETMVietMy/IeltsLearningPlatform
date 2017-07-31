class CreateCorrections < ActiveRecord::Migration[5.1]
  def change
    create_table :corrections do |t|
      t.integer :teacher_id
      t.references :writing, foreign_key: true
      t.text :body
      t.string :status, default: 'new'
      t.float :task_achievement
      t.float :coherence_cohesion
      t.float :lexical_resource
      t.float :grammar

      t.timestamps
    end
    add_index :corrections, [:teacher_id, :status]
  end
end
