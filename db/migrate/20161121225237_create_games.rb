class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.integer :card1
      t.integer :card2
      t.integer :card3
      t.boolean :game1_win
      t.boolean :game2_win
      t.boolean :game3_win

      t.timestamps
    end
  end
end
