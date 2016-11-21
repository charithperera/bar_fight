class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :wins
      t.integer :losses
      t.integer :card_count
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
