class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :artist, null: false
      t.string :album_name, null: false
      t.string :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :albums, :artist
    add_index :albums, :album_name
  end
end
