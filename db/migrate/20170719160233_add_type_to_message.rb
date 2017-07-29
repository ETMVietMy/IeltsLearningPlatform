class AddTypeToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :message_type, :string, default: 'msg'
    add_index :messages, [:message_type]
  end
end
