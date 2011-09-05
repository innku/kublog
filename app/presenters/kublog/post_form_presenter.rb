module Kublog
  class PostFormPresenter
    
    attr_accessor :post, :notifications
    
    def initialize(post)
      @post  = post
      @notifications = []
      @notifications << notification('twitter')
      @notifications << notification('facebook')
      @notifications << notification('email')
    end
    
    def notification(kind)
      @post.notifications.build(:kind => kind, :post => @post)
    end
    
  end
end