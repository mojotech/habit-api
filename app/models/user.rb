class User < ActiveRecord::Base
  include TokenAuthenticable

  has_and_belongs_to_many :habits
  has_many :checkins
  has_many :targets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :display_name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.display_name = auth.info.name
    end
  end

  def remember_me
    true
  end
end
