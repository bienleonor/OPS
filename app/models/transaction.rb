class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User", optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true

  enum :transaction_type, {
    transfer: "transfer",
    deposit: "deposit",
    withdraw: "withdraw"
  }, suffix: true

  scope :for_user, ->(user) {
    where(sender: user).or(where(receiver: user))
  }

  scope :recent, -> {
    order(created_at: :desc)
  }

  def direction_for(user)
    sender == user ? :deduction : :addition
  end

  def other_party_name(user)
    sender == user ? receiver&.email || "N/A" : sender.email
  end
end
