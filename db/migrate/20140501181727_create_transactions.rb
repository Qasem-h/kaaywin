class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.integer :transaction_type
      t.string :comment

      t.timestamps
    end
  end
end
