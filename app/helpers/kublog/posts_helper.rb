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
    
    def atom_url(presenter)
      presenter.category.nil? ? posts_url(:format => :atom) : category_url(presenter.category, :format => :atom)
    end
    
    def hide_if_no_invited_author(post)
      "display:none" unless display_invited_author_form?(post)
    end

    # To understand this, you need to know that
    # regardless if the user wants or not the invited author,
    # we need to build the invited author form so the form
    # is displayed appropiatly.
    # So asking if the post has an invited author is not enough
    def display_invited_author_form?(post)
      !(post.new_record? || post.invited_author.new_record?)
    end
  end
end
