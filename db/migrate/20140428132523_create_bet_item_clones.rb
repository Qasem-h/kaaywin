class CreateBetItemClones < ActiveRecord::Migration
  def change
    create_table :bet_item_clones do |t|
      t.integer :bet_item_id
      t.float :odds

      t.timestamps
    end
  end
end
