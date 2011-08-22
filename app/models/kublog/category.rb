module Kublog
  class Category < ActiveRecord::Base
    extend FriendlyId
    
    has_many  :posts,       :dependent => :nullify
    
    validates_presence_of   :name
    validates_uniqueness_of :name
    
    friendly_id             :name, :use => :slugged
    
    def to_s
      self.name.titleize
    end
    
    # Site access to the category
    def path
      Engine.routes.url_helpers.category_path(self)
    end
    
    def as_json(params={})
      super params.merge({:methods => [:path]})
    end
    
  end
end
