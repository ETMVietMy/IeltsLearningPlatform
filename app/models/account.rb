class Account < ApplicationRecord
  belongs_to :user

  def get_transactions
    @transactions ||= Transaction.where("(from_account = ? OR to_account = ?) AND status = ?",
                                        self.id, self.id, Transaction::DONE).order("updated_at desc")
  end

  def get_pending_transactions
    @pending_transactions ||= Transaction.where("(from_account = ? OR to_account = ?) AND status = ?",
                                        self.id, self.id, Transaction::PENDING).order("updated_at desc")
  end

  # transfer coins function from account to account
  def transfer(to_account, amount)
    to_acc = Account.find_by(id: to_account)

    if to_acc.nil?
      self.errors.add("Transaction denied! Cannot get data of account.")
      return
    end

    if self.balance<amount
      self.errors.add("Transaction denied! Insufficient ballance to cover transfer amount.")
      return
    end

    Transaction.transfer(self.id, to_account, amount, "A2A")
  end

  # Top up account function for admin only
  def self.top_up_account(account_id, amount)
    to_acc = Account.find_by(id: account_id)

    if to_acc.nil?
      # TODO raise an error
      # self.errors.add("Transaction denied! Cannot get data of account.")
      return
    end

    Transaction.transfer('', account_id, amount, "TOPUP")
  end

  # Set pending transaction for writing
  def self.start_payment_for_correcting(from_account, to_account, amount, writing_id)
    to_acc = Account.find_by(id: to_account)
    from_acc = Account.find_by(id: from_account)

    if to_acc.nil? || from_acc.nil?
      self.errors.add("Transaction denied! Cannot get data of account.")
      return
    end

    if from_acc.balance<amount
      self.errors.add("Transaction denied! Insufficient ballance to cover transfer amount.")
      return
    end

    Transaction.transfer(from_account, to_account, amount, 'PAYMENT', writing_id)
  end

  # Settle Payment for writing
  def self.settle_payment_for_correcting(from_account, to_account, amount, writing_id)
    # puts from_account, to_account, amount, writing_id
    to_acc = Account.find_by(id: to_account)
    from_acc = Account.find_by(id: from_account)

    if to_acc.nil? || from_acc.nil?
      self.errors.add("Transaction denied! Cannot get data of account.")
      return
    end

    if from_acc.balance<amount
      self.errors.add("Transaction denied! Insufficient ballance to cover transfer amount.")
      return
    end

    Transaction.transfer(from_account, to_account, amount, 'SETTLE_PAYMENT', writing_id)
  end

  # get income last 30 days
  def getIncomeLast30
    Transaction.where(status: 'DONE', to_account: self.id, updated_at: (Time.now.midnight - 30.day)..Time.now.midnight).map(&:amount).sum
  end

  # get outcome last 30 days
  def getOutcomeLast30
    Transaction.where(status: 'DONE', from_account: self.id, updated_at: (Time.now.midnight - 30.day)..Time.now.midnight).map(&:amount).sum
  end

end
