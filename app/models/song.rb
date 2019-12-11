class Song < ActiveRecord::Base
  validates :title, :presence => true
  validates :artist, :presence => true
  validates :album, :presence => true
  validates :tempo, :presence => true
  validates :main_genre_id, :presence => true

  default_scope {order('date_added DESC')}

  belongs_to :user
  belongs_to :main_genre ,  :class_name => 'Genre' , optional: true

  def user_name
    if self.user_id and self.user
      self.user.full_name
    else
      self.read_attribute(:user_name)
    end
  end

  def added_on
    return self.date_added if self.date_added
    self.added
  end

  def self.tempo_list
     ["ambient", "very slow", "slow", "medium-slow", "medium", "medium-fast",
       "fast", "very fast", "varies"]
  end

end
