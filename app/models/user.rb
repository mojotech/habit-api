class User < ActiveRecord::Base
  has_and_belongs_to_many :habits
  has_many :checkins
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include TokenAuthenticable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
