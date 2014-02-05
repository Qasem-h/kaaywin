class AddEventIdToBets < ActiveRecord::Migration
  def change
  	add_column :bets, :league_id, :integer
  end
end
