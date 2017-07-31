class TransactionsController < ApplicationController
  layout 'dashboard'

  def index
    @account = current_user.account
    @transactions = @account.get_transactions
    if current_user.is_admin?
      @pending_transactions = Transaction.where(status: Transaction::PENDING)
    else
      @pending_transactions = @account.get_pending_transactions
    end
  end

  def create
    @transaction = Transaction.new(transactions_params)
    @transaction_type = TransactionType.find(@transaction.transaction_type_id)

    if @transaction_type.topup?
      Transaction.transfer(current_user.account.id, @transaction.to_account, @transaction.amount, @transaction_type.code)
      flash[:success] = "Top Up #{@transaction.amount} Coins successfully."
      redirect_to account_path
    elsif @transaction_type.a2a?
      Transaction.transfer(current_user.account.id, @transaction.to_account, @transaction.amount, @transaction_type.code)
      flash[:success] = "Transfer #{@transaction.amount} Coins successfully."
      redirect_to account_path
    end

  end

  private

  def transactions_params
    params.require(:transaction).permit(:from_account, :to_account, :amount, :transaction_type_id, :writing_id, :promo_code_id)
  end
end
