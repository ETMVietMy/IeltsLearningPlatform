class TransactionsController < ApplicationController
  layout 'dashboard'

  def index
    @transactions = current_user.account.present? ? current_user.account.get_transactions : []
    @pending_transaction = current_user.account.present? ? current_user.account.get_pending_transactions : []
  end
end
