class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :title
      t.integer :event_id

      t.timestamps
    end
  end
end
