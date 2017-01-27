module BankTransactions
  class AccountUpgrade < BankTransaction
    serialize :data, JSON
    before_validation :initialize_amount

    COST = 500
    DURATION = 7

    def self.revert_upgrade(user_id, old_level)
      user = User.find(user_id)

      if old_level > user.level
        user.level = old_level 
        user.save
      end
    end

    def self.in_progress?(user_id)
      # data is stored as a string so we're counting on iso8601 formatting so this
      # comparison works correctly
      where(user_id: user_id).where("data > ?", Time.now.iso8601.to_json).exists?
    end

    def initialize_amount
      self.amount = -1 * COST
      self.data = expires_at
    end

    def expires_at
      DURATION.days.from_now
    end

    def upgrade_account
      if user.level < User::Levels::PLATINUM
        BankTransactions::AccountUpgrade.delay(:run_at => expires_at).revert_upgrade(user_id, user.level)
        user.level = User::Levels::PLATINUM
        user.save
      end
    end

  end
end
