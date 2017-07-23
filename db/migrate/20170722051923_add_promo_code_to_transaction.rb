class AddPromoCodeToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :promo_code, foreign_key: true
  end
end
