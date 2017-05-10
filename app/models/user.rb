class User < ActiveRecord::Base

  has_secure_password

  has_many :tips
  has_many :languages, through: :tips

  validates_presence_of  :username, :email, :password_digest
  validates_uniqueness_of :username, :email

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
