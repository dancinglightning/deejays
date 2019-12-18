class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :presence => true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true, disallow_subaddressing: true}
  validates :country, :presence => true
  validates :city, :presence => true

  has_many :songs
  scope :admin, -> { where(admin: '1') }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
