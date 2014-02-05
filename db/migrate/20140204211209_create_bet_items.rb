class CreateBetItems < ActiveRecord::Migration
  def change
    create_table :bet_items do |t|
      t.string :name
      t.string :odds
      t.integer :bet_id

      t.timestamps
    end
    add_index :bet_items, :bet_id
  end
end
