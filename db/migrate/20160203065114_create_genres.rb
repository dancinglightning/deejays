class CreateGenres < ActiveRecord::Migration[4.2]
  def change
    Song.all.each do |song|
      song.update_attribute('sub_genre', song.main_genre)
      song.update_attribute('main_genre', "")
    end
    create_table :genres do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
