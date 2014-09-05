class User < ActiveRecord::Base
  include TokenAuthenticable

  has_and_belongs_to_many :habits
  has_many :checkins
  has_many :targets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :display_name, presence: true

  serialize :image

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.display_name = auth.info.name
      user.send(:image=, auth.info.image, auth.provider)
    end
  end

  def image=(url, provider)
    if provider == "facebook"
      write_attribute :image, { small: url, large: "#{url}?type=large"}
    end
  end

  def remember_me
    true
  end
end
