class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.references :user
      t.string :nationality
      t.decimal :price
      t.text :experience
      t.string :linkedin

      t.timestamps
    end
  end
end
