class CreateScratchCards < ActiveRecord::Migration
  def change
    create_table :scratch_cards do |t|
      t.string :hidden_number
      t.float :credit
      t.integer :status
      t.integer :ticket_id, default:  -1

      t.timestamps
    end
    add_index :scratch_cards, :ticket_id
  end
end
