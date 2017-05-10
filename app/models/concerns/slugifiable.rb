module Slugifiable
  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ", "-")
    end
  end

  module ClassMethods
    def find_with_slug(slug)
      self.all.find do |s|
        s.slug == slug
      end
    end
  end

end
