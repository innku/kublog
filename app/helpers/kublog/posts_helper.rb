module Kublog
  module PostsHelper
    VERSIONS = [['',''],
                ['original', 'Insert Original'], 
                ['small', 'Insert Small (140x140)'],
                ['thumb', 'Insert Thumbnail (54x54)']]
    
    def size_options
      @size_options ||= options_from_collection_for_select(VERSIONS, :first, :second)
    end
    
    def category_options(post)
      categories = Kublog::Category.all
      category_options = options_from_collection_for_select(categories, :id, :name, post.category.try(:id))
      options = "<option value='' class='blank'></option>"
      options += category_options      
      options += "<option value='create_new_category'>New category...</option>"
      options
    end
    
    def user_kinds
      Kublog.user_kinds
    end
    
    def missing_image_url
      Kublog::FileUploader.new.default_url
    end
    
    def display?(should)
      should ? 'display:block' : 'display:none'
    end
    
    def admin_comment?(comment)
      comment.admin? ? 'admin' : ''
    end
    
    def atom_url(presenter)
      presenter.category.nil? ? posts_url(:format => :atom) : category_url(presenter.category, :format => :atom)
    end
    
  end
end
