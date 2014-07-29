class User < ActiveRecord::Base
  include TokenAuthenticable

  has_and_belongs_to_many :habits
  has_many :checkins

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
