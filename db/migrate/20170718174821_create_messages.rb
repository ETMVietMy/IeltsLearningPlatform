class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.bigint :sender
      t.string :subject
      t.text :content
      t.boolean :is_read

      t.timestamps
    end
  end
end
