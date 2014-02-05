class AddFieldToBets < ActiveRecord::Migration
  def change
  	add_column :bets, :event_id, :integer
  end
end
