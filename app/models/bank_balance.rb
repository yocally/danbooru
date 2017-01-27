class BankBalance < ActiveRecord::Base
  belongs_to :user

  def self.generate_nonce
    SecureRandom.urlsafe_base64(32)
  end

  def self.initialize_balance(user)
    if user.bank_balance.nil?
      user.create_bank_balance(amount: 0, nonce: generate_nonce)
    end
  end
end
