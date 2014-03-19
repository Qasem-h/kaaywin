class ChangeDefaultValueActiveToBetItems < ActiveRecord::Migration
  def change
  	change_column :bet_items, :active, :boolean, :default => false
  end
end
