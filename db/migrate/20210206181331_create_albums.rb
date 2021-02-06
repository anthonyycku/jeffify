class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.serial :id
      t.string :name
      t.string :artist
      t.text :image
      t.integer :year
      t.integer :artist_id

      t.timestamps
    end
  end
end
