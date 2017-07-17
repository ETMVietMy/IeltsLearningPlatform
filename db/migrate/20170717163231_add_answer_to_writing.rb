class AddAnswerToWriting < ActiveRecord::Migration[5.1]
  def change
    add_column :writings, :answer, :text
  end
end
