module Kublog
  class PostsController < ApplicationController
    
    skip_filter   :require_admin, :only => [:index, :show]
    
    def index
      @presenter = PostsPresenter.new
      respond_to do |format|
        format.html { }
        format.atom { render :layout => false }
        format.rss  { redirect_to posts_path(:format => :atom), :status => :moved_permanently }
      end
    end
    
    def new
      @presenter = PostFormPresenter.new(Post.new)
    end
    
    def show
      post = Post.find(params[:id])
      @presenter = PostPresenter.new(post)
    end
    
    def create
      @post = current_user.posts.build(params[:post])
      if @post.save
        redirect_to @post
      else
        @presenter = PostFormPresenter.new(@post)
        render 'new'
      end
    end
    
    def edit
      @presenter = PostFormPresenter.new(Post.find(params[:id]))
    end
    
    def update
      @post = Post.find(params[:id])
      if @post.update_attributes(params[:post])
        redirect_to @post
      else
        @presenter = PostFormPresenter.new(@post)
        render 'edit'
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path
    end
    
  end
end
