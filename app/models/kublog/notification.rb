module Kublog
  class Notification < ActiveRecord::Base    
    include Network::Email, Network::Facebook, Network::Twitter
    
    belongs_to :post
    
    validates_presence_of :kind, :content
    
    after_create  :deliver
    serialize     :roles, Hash
    
    delegate      :title, :url, :to => :post
        
    def default?
      self.send "default_#{kind}"
    end
    
    private
    
    def deliver
      self.send "deliver_#{kind}"
    end
    
  end
end
