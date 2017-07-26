class TransactionsController < ApplicationController
  layout 'dashboard'

  def index
<<<<<<< HEAD
    @transactions = current_user.account.present? ? current_user.account.get_transactions : []
    @pending_transaction = current_user.account.present? ? current_user.account.get_pending_transactions : []
=======
    @account = current_user.account
    @transactions = @account.get_transactions
    @pending_transactions = @account.get_pending_transactions
>>>>>>> minhdh_dev
  end
end
