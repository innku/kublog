module Kublog
  class PostFormPresenter
    
    attr_accessor :post, :notifications
    
    def initialize(post)
      @post  = post
      @notifications = []
      @notifications << notification('twitter')  if Kublog.twitter?
      @notifications << notification('facebook') if Kublog.facebook?
      @notifications << notification('email') if Kublog.email?
      @post.build_invited_author unless @post.invited_author
    end
    
    def notification(kind)
      @post.notifications.build(:kind => kind, :post => @post)
    end
    
  end
end
