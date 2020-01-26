class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :presence => true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true, disallow_subaddressing: true}
  validates :country, :presence => true
  validates :city, :presence => true

  validate :has_http
  validate :is_alpha
  validate :is_minsk
  validate :capitals

  has_many :songs
  scope :admin, -> { where(admin: '1') }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def has_http
    return unless self.full_name.include?("http")
    errors.add(:full_name , "You know what")
  end
  def is_alpha
    return unless self.full_name.match( /\d/)
    errors.add(:full_name , "No digits allowed in names")
  end
  def is_minsk
    return unless self.city == "Minsk"
    return if self.country == "Belarus"
    errors.add(:city , "Me thinks you may live in Belarus")
  end
  def capitals
    [:city, :full_name, :country , :state].each do |attr|
      errors.add(attr , "You have your caps lock on") if(has_caps(attr) > 2)
    end
  end
  def has_caps(attr)
    value = self.send(attr)&.delete(" ")
    return 0 if value.blank?
    up = value.upcase
    total = 0
    (0 ... value.length).each {|i| total += 1 if value[i] == up[i]}
    total
  end
end
