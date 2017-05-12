class User < ActiveRecord::Base

  has_secure_password

  has_many :tips
  has_many :languages, through: :tips

  validates :username, :email, presence: true, uniqueness: true

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
