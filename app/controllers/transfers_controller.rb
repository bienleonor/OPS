class TransfersController < ApplicationController
  before_action :require_login
  def send_money
  end
  def receive_money
  end

  def create
    receiver = User.find_by(email: params[:receiver_email])
    amount = params[:amount].to_f

    if receiver.nil?
      flash[:alert] = "Receiver not found"
      redirect_to send_money_transfers_path and return
    end

    begin
      TransferService.call(sender: current_user, receiver: receiver, amount: amount)
      flash[:notice] = "Transfer successful!"
      redirect_to send_money_transfers_path
    rescue => e
      flash[:alert] = e.message
      redirect_to send_money_transfers_path
    end
  end
end
