class CreateBetType < ActiveRecord::Migration
  def change
    create_table :bet_types do |t|
      t.string :name
    end
  end
end
