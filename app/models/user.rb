class User < ApplicationRecord
  has_secure_password
  has_one :wallet, dependent: :destroy
  after_create :create_wallet

  has_many :sent_transactions, class_name: "Transaction", foreign_key: :sender_id
  has_many :received_transactions, class_name: "Transaction", foreign_key: :receiver_id

  private

  def create_wallet
    Wallet.create(user: self, balance: 0)
  end
end
