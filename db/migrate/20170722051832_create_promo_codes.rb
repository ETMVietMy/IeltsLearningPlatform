class CreatePromoCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :promo_codes do |t|
      t.string :name
      t.string :code
      t.integer :percent
      t.integer :limit

      t.timestamps
    end
  end
end
