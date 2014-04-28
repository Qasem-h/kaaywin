class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.datetime :date
      t.integer :status
      t.float :stake
      t.float :payout

      t.timestamps
    end
  end
end
