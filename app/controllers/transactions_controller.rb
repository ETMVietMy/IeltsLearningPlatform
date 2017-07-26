class TransactionsController < ApplicationController
  layout 'dashboard'

  def index
    @account = current_user.account
    @transactions = @account.get_transactions
    @pending_transactions = @account.get_pending_transactions
  end
end
