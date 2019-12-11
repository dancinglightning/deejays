class CreateSongs < ActiveRecord::Migration[4.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.string :speed
      t.string :genre
      t.string :link
      t.string :info

      t.timestamps null: false
    end
  end
end
