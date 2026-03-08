class TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.for_user(current_user).recent
  end
end
