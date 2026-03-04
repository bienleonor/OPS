class TransferService
  def self.call(sender:, receiver:, amount:)
    raise "Cannot send to yourself" if sender.id == receiver.id
    raise "Amount must be greater than 0" if amount <= 0

    ActiveRecord::Base.transaction do
      sender_wallet = sender.wallet
      receiver_wallet = receiver.wallet

      raise "Insufficient balance" if sender_wallet.balance < amount

      sender_wallet.update!(balance: sender_wallet.balance - amount)
      receiver_wallet.update!(balance: receiver_wallet.balance + amount)

      Transaction.create!(
        sender: sender,
        receiver: receiver,
        amount: amount,
        transaction_type: "transfer"
      )
    end
  end
end