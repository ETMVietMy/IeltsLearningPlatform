class Transaction < ApplicationRecord
  belongs_to :transaction_type

  # define status for transaction
  PENDING = 'PENDING'
  DONE = 'DONE'
  CANCEL = 'CANCEL'
  %w(pending done cancel).each do |state|
    define_method "#{state}?" do
      status == self.class.const_get(state.upcase)
    end
  end

  def self.transfer(from_account, to_account, amount, type, writing_id = nil)
    puts "#{from_account}, #{to_account}, #{amount}, #{type}, #{writing_id} "
    @from_acc = Account.find_by(id: from_account)
    @to_acc = Account.find_by(id: to_account)
    @trans_type = TransactionType.find_by(code: type)
    if @trans_type.a2a?
      @transaction = Transaction.new(from_account: from_account, to_account: to_account, transaction_type_id: @trans_type.id,
                         amount: amount, status: Transaction::DONE, writing_id: nil, promo_code_id:nil,
                         transaction_description: "Transfer from #{@from_acc.user.email} to #{@to_acc.user.email}")
      if @transaction.save
        @from_acc.balance -= amount
        @to_acc.balance += amount
        @from_acc.save
        @to_acc.save
      end
    elsif @trans_type.pending_payment?
      @transaction = Transaction.new(from_account: from_account, to_account: to_account, transaction_type_id: @trans_type.id,
                         amount: amount, status: Transaction::PENDING, writing_id: writing_id, promo_code_id: nil,
                         transaction_description: "Pending: Payment for correcting from #{@from_acc.user.email} to teacher #{@to_acc.user.email}")
      if @transaction.save
        @from_acc.balance -= amount
        @from_acc.save
      end
    elsif @trans_type.topup?
      @transaction = Transaction.new(from_account: from_account, to_account: to_account, transaction_type_id: @trans_type.id,
                         amount: amount, status: Transaction::DONE, writing_id: nil, promo_code_id: nil,
                         transaction_description: "Top Up #{amount} Coins to #{@to_acc.user.email}")

      if @transaction.save
        @to_acc.balance += amount
        @to_acc.save
      end
    elsif @trans_type.settle_payment?
      @transaction = Transaction.find_by(from_account: from_account, to_account: to_account, amount: amount, writing_id: writing_id)
      @transaction.status = Transaction::DONE
      @transaction.transaction_type_id = @trans_type.id
      @transaction.transaction_description = "Settle: Payment for correcting from #{@from_acc.user.email} to teacher #{@to_acc.user.email}"
      if @transaction.save
        @to_acc.balance += amount
        @to_acc.save
      end
    end
  end

  def cancel
    if self.type == PENDING
      self.status = CANCEL
      self.transaction_description = "Cancel: Payment for writing"
      self.save
      @from_acc = Account.find_by(id: from_account)
      @from_acc.balance += amount
      @from_acc.save
    end
  end
end
