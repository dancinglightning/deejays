module Features
  module SongHelpers
    def fill_new_song
      genre = create :genre
      visit new_song_path
      song = build :song
      fill_song song , genre
    end

    def fill_song song , genre
      fill_in 'Title', :with => song.title
      fill_in 'Artist', :with => song.artist
      fill_in 'Album', :with => song.album
      within "#song_tempo" do
        find("option[value='#{song.tempo}']").select_option unless song.tempo.blank?
      end
      within '#song_main_genre_id' do
        find("option[value='#{genre.id}']").select_option
      end
      song
    end

    def edit_song
      user = signed_user :given_user
      song = create :song , :user_id => user.id
      visit edit_song_path(song)
      fill_song song , song.main_genre
      click_button 'Update Song'
      expect(page).to have_content("successfully updated")
      user
    end

    def add_song
      user = signed_user
      fill_new_song
      click_button 'Create Song'
      expect(page).to have_content("successfully created")
      expect(user.songs.count).to eq 1
      user
    end
  end
end
