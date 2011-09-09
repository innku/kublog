module Kublog
  class PostsPresenter
    
    attr_accessor :category
    
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
      @title ||= @category.nil? ? Kublog.blog_name : "#{@category.name} :: #{Kublog.blog_name}"
    end
    
    def updated
      self.posts.first.try(:updated_at) - 1.seconds
    end
    
    def ftime(updated)
      updated.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
    
  end
end