class TransactionType < ApplicationRecord
  has_many :transactions

  # define constant for transaction_type
  TOPUP = 'TOPUP'
  PENDING_PAYMENT = 'PAYMENT'
  SETTLE_PAYMENT = 'SETTLE_PAYMENT'
  A2A = 'A2A'
  %w(topup pending_payment settle_payment a2a).each do |state|
    define_method "#{state}?" do
      code == self.class.const_get(state.upcase)
    end
  end

end
