class AddOddTypePrintedToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :odds, :float
  	
  	add_column :tickets, :printed, :integer
  end
end
