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

    Transaction.transfer('', account_id, amount, Transaction::TOPUP)
  end

  #

end
