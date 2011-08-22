module Kublog
  class PostsPresenter
    
    def initialize(category=nil)
      @category = category
    end
    
    def categories
      @categories ||= Category.all
    end
    
    def posts
      @posts ||= @category ? @category.posts : Post.all
    end
    
    def title
      Kublog.blog_name
    end
    
    def updated
      self.posts.first.try(:updated_at)
    end
    
    def ftime(updated)
      updated.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
    
  end
end