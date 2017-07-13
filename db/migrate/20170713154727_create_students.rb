class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
    	t.string :name
    	t.string :email
    	t.string :password_digest
    	t.integer :user_id
    	t.datetime "created_at",   null: false
    	t.datetime "updated_at",   null: false

      t.timestamps
    end
  end
end
