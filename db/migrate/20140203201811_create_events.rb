class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :league_id
      t.boolean :active, default: false
      t.datetime :date

      t.timestamps
    end
    add_index :events, :name
  end
end
