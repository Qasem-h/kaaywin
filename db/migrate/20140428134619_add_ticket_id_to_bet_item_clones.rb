class AddTicketIdToBetItemClones < ActiveRecord::Migration
  def change

  	add_column :bet_item_clones, :ticket_id, :integer
  end
end
