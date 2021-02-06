class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.serial :id
      t.string :name
      t.string :artist
      t.integer :album_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
