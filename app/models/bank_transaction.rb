class BankTransaction < ActiveRecord::Base
  belongs_to :user
  after_create :update_balance
  validates_uniqueness_of :nonce
  before_validation :initialize_balance
  before_validation :initialize_nonce

  def initialize_balance
    BankBalance.initialize_balance(user)
  end

  def initialize_nonce
    self.nonce = user.bank_balance.nonce
  end

  def update_balance
    BankBalance.where(user_id: user_id).update_all(["amount = (select sum(amount) from bank_transactions where user_id = ?), nonce = ?", user_id, BankBalance.generate_nonce])
  end
end
