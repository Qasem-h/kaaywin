class AddUserIdScratchCardIdToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :user_id, :integer, default: -1
  	add_column :tickets, :scratchcard_id, :integer, default: -1
  	end
end
