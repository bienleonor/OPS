class TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.where(sender: current_user)
                               .or(Transaction.where(receiver: current_user))
                               .order(created_at: :desc)
  end
end