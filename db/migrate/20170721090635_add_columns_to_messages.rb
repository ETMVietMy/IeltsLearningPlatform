class AddColumnsToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :hide_sender, :boolean, default: false
    add_column :messages, :hide_recipient, :boolean, default: false
    add_column :messages, :recipients_emails, :string
  end
end
