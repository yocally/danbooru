class CreateBankTransactions < ActiveRecord::Migration
  def change
    create_table :bank_transactions do |t|
      t.integer :user_id, null: false
      t.integer :amount, null: false
      t.string :nonce, null: false
      t.string :type, null: false
      t.text :data
      t.timestamps null: false
    end

    add_index :bank_transactions, :user_id
    add_index :bank_transactions, :created_at
    add_index :bank_transactions, :nonce, unique: true
  end
end
