class Tip < ActiveRecord::Base
  belongs_to :user
  belongs_to :language

  validates :content, presence: true


  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
