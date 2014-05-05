class RenameScratchcardToTickets < ActiveRecord::Migration
  def change
  	rename_column :tickets, :scratchcard_id, :scratch_card_id
  end
end
