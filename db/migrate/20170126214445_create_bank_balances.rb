class CreateBankBalances < ActiveRecord::Migration
  def change
    create_table :bank_balances do |t|
    	t.integer :user_id, null: false
    	t.integer :amount, null: false
      t.timestamps null: false
      t.string :nonce, null: false
    end

    add_index :bank_balances, :user_id, unique: true
  end
end
