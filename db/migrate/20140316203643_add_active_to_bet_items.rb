class AddActiveToBetItems < ActiveRecord::Migration
	# to modify the bet_item for making them active or not during resul entering
  def change
  	add_column :bet_items, :active, :boolean, :default => true
  end
end
