class AddWritingIdToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :writing_id, :integer
    add_index :messages, [:writing_id]
  end
end
