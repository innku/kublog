module Kublog
  class Notification < ActiveRecord::Base    
    include Network::Email, Network::Facebook, Network::Twitter
    
    belongs_to :post
    
    # Presence of content should be responsability
    # Of each network module
    validates_presence_of :kind
    
    after_create  :deliver
    serialize     :roles, Array
    
    delegate      :title, :url, :to => :post
    attr_accessible :post, :kind, :content, :roles
        
    def default?
      self.send "default_#{kind}"
    end
    
    private
    
    def deliver
      self.send "deliver_#{kind}" if respond_to?("deliver_#{kind}")
    end
    
  end
end
