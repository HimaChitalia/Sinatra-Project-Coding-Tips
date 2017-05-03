class User < ActiveRecord::Base

  has_many :tips
  has_many :languages, through: :tips

  has_secure_password

  validates :name, :username, :email, :password_digest, :presence => true

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
