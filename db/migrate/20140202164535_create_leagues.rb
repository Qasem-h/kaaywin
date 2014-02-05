class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name, unique: true
      t.string :country
      t.string :sport
      t.string :comments

      t.timestamps

      
    end
  end
end
