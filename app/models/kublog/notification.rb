module Kublog
  class Notification < ActiveRecord::Base
    include Network::Email
    
    belongs_to :post
    
    validates_presence_of :kind, :content
    
    after_create  :deliver
    serialize     :roles, Hash
    
    private
    
    def deliver
      self.send "deliver_#{kind}"
    end
    
  end
end
