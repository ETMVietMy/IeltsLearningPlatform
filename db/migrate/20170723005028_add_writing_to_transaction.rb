class AddWritingToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :writing, foreign_key: true
  end
end
