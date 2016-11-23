class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :challenger_id
      t.integer :challenger_cardid
      t.string :challenger_powername
      t.integer :challenger_powerval
      t.integer :opponent_id
      t.integer :opponent_cardid
      t.string :opponent_powername
      t.integer :opponent_powerval

      t.timestamps
    end
  end
end
