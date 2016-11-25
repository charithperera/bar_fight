class AddSadImageToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :sad_image_url, :string
  end
end
