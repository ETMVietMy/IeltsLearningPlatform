class TransactionType < ApplicationRecord
  has_many :transactions

  # define constant for transaction_type
  TOPUP = 'TOPUP'
  PENDING_PAYMENT = 'PAYMENT'
  SETTLE_PAYMENT = 'SETTLE_PAYMENT'
  A2A = 'A2A'
  CANCEL = 'CANCEL'
  %w(topup pending_payment settle_payment a2a cancel).each do |state|
    define_method "#{state}?" do
      code == self.class.const_get(state.upcase)
    end
  end

  # Type of transactions
  def self.get_topup_id
    @topup_id ||= TransactionType.find_by(code: TOPUP).id
  end
  def self.get_payment_id
    @payment_id ||= TransactionType.find_by(code: PAYMENT).id
  end
  def self.get_settle_payment_id
    @settle_payment_id ||= TransactionType.find_by(code: SETTLE_PAYMENT).id
  end
  def self.get_a2a_id
    @a2a_id ||= TransactionType.find_by(code: A2A).id
  end
  def self.get_cancel_id
    @a2a_id ||= TransactionType.find_by(code: CANCEL).id
  end
end
