module Kublog
  class PostPresenter
    
    attr_accessor :post
    
    def initialize(post=nil)
      @post = post
    end
    
    def comment_count
      @comment_count ||= comments.count
    end
    
    def comments
      @comments ||= @post.comments
    end
    
    def related_posts
      @related_posts ||= @post.related_posts.try(:limit, 5) || []
    end

  end
end