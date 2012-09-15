# Non mandatory single category for a post
# implements friendly_id search and json defaults
# for ajax editing
module Kublog
  class Category < ActiveRecord::Base
    extend FriendlyId
    
    has_many  :posts,       :dependent => :nullify
    
    validates_presence_of   :name
    validates_uniqueness_of :name
    
    friendly_id             :name, :use => :slugged

    attr_accessible :name
    
    def to_s
      self.name.titleize
    end
    
    # Includes a path to the category by default
    # helps reference back to edited categories in
    # json requests
    def as_json(params={})
      params||={}
      super(params.merge!({:methods => [:path]}))
    end
    
    protected
    
    def path
      Engine.routes.url_helpers.category_path(self)
    end
    
  end
end
