RSpec.describe Song, type: :model do

  it "factories ok" do
    genre = create :genre
    song = build :song , main_genre: genre
    expect(song.save).to be true
  end

  it "factories invalid" do
    song = build :invalid_song
    expect(song.save).to be false
  end

  it "checks all attributes" do
    ["title","artist", "album","tempo"].each do |att|
      song = build :song
      song.send "#{att}=".to_sym , ""
      expect(song.save).to be false
    end
  end
end
