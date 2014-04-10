class CreateBetTypes < ActiveRecord::Migration
  def change
    create_table :bet_types do |t|

      t.timestamps
    end
  end
end
