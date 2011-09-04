module Kublog
  class PostFormPresenter
    
    attr_accessor :post, :notifications
    
    def initialize(post)
      @post  = post
      @notifications = []
      @notifications << notification('email')
      @notifications << notification('facebook')
      @notifications << notification('twitter')
    end
    
    def notification(kind)
      @post.notifications.build(:kind => kind, :post => @post)
    end
    
  end
end