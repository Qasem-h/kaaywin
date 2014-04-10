class ChangeBetTypeToBets < ActiveRecord::Migration
  def change
  	rename_column :bets, :bet_type, :bet_type_id
  end
end
