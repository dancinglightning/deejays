class AddAddedToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :added, :date
  end
end
