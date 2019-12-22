FactoryBot.define do
  factory :invalid_song , class: Song do
    sequence(:title) { |n| "Sunshine #{n}" }
    artist {"Mc Yogi"}
    album {"Meditation"}
    tempo {"fast"}
    factory :ok_song do
      association :main_genre, factory: :genre
      link {"http://mcyogi.com"}
      info {"Mc is a yogi"}
      factory :song do
        user { create :user }
      end
      factory :given_song do
        user { create :given_user }
      end
    end
  end

end
