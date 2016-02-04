# Song adding should lead to being able to see the list
feature 'Song add' do

  scenario 'edit a song as user' do
    user = edit_song
  end

  scenario 'edit a song without tempo and get error' do
    user = signed_user
    fill_new_song
    fill_in 'Tempo', :with => ""
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
end
