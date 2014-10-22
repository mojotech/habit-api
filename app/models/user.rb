class User < ActiveRecord::Base
  include TokenAuthenticable

  has_many :targets
  has_many :habits, through: :targets
  has_many :checkins

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

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

  def email_required?
    super && provider.blank?
  end

  def image=(url, provider)
    if provider == "facebook"
      write_attribute :image, { small: url, large: "#{url}?type=large"}
    else  provider == "twitter"
      write_attribute :image, { small: url, large: url.sub('_normal', '') }
    end
  end

  def remember_me
    true
  end
end
