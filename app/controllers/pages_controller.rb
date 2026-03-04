class PagesController < ApplicationController
  layout "application"
  before_action :require_login

  def home
    @transactions = current_user.sent_transactions + current_user.received_transactions
    @transactions.sort_by!(&:created_at).reverse!
  end
end