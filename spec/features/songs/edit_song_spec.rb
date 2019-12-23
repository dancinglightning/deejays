# Song adding should lead to being able to see the list
feature 'Song edit' do

  scenario 'edit a song as user' do
    user = edit_song
  end

  scenario "admin edits users song" do
    admin = signed_user :admin
    song = create :song
    visit edit_song_path(song)
    fill_song song , song.main_genre
    click_button 'Update Song'
    expect(page).to have_content("successfully updated")
  end

  scenario 'edit a song without Artist and get error' do
    user = signed_user
    fill_new_song
    fill_in 'Artist', :with => ""
    click_button 'Create Song'
    expect(page).to have_content("review the problems")
    expect(user.songs.count).to eq 0
  end

  it "shows all form fields" do
    signed_user
    fill_new_song
    ["Add a new" , "Album" , "Artist" , "Tempo" ,"Main genre",
      "Sub genre" , "Link" , "Info"].each do |cont|
      expect(page).to have_content(cont)
    end
  end

  it "admin song edit" do
    signed_user
    fill_new_song
    ["Add a new" , "Album" , "Artist" , "Tempo" ,"Main genre",
      "Sub genre" , "Link" , "Info"].each do |cont|
      expect(page).to have_content(cont)
    end
  end

  scenario "admin deletes song" , :js  do
    admin = signed_user :admin
    song = create :song
    visit edit_song_path(song)
    accept_alert do
      click_link 'Delete Song'
    end
    expect(page).to have_content "Song deleted"
  end

  scenario "user can not delete other song"  do
    user = signed_user :user
    song = create :song , user: user
    visit edit_song_path(song)
    expect(page).not_to have_content "Delete Song"
  end

end
