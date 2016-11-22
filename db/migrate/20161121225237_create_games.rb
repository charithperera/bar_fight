class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :challenger_id
      t.integer :challenger_card1
      t.integer :challenger_card2
      t.integer :challenger_card3
      t.integer :opponent_id
      t.integer :opponent_card1
      t.integer :opponent_card2
      t.integer :opponent_card3
      t.integer :game1_win_by
      t.integer :game2_win_by
      t.integer :game3_win_by

      t.timestamps
    end
  end
end
