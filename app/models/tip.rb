class Tip < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
