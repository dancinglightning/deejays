class AddDateAddedToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :date_added, :date
  end
end
