class AddDefaultToWritings < ActiveRecord::Migration[5.1]
  def change
    change_column_default :writings, :status, 'new'
  end
end
