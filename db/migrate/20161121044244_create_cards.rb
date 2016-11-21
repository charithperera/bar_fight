class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :earth
      t.integer :wind
      t.integer :fire
      t.string :special
      t.text :image_url

      t.timestamps
    end
  end
end
