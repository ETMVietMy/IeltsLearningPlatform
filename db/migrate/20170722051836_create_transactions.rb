class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.bigint :from_account
      t.bigint :to_account
      t.integer :amount
      t.string :transaction_description
      t.references :transaction_type, foreign_key: true

      t.timestamps
    end
  end
end
