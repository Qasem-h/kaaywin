class ChangeToBets < ActiveRecord::Migration
  def change
  	change_column :bets, :bet_type, :integer
  end
end
