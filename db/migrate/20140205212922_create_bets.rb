class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :name
      t.string :bet_type

      t.timestamps
    end
  end
end
