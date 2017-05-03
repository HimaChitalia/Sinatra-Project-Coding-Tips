class Language < ActiveRecord::Base
  has_many :tips
  has_many :users, through: :tips
  
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
