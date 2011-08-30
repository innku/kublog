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
      @post = Post.new
    end
    
    def show
      post = Post.find(params[:id])
      @presenter = PostPresenter.new(post)
    end
    
    #TODO: Figure out a proxy method to access User
    def create
      @post = current_user.posts.build(params[:post])
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def update
      @post = Post.find(params[:id])
      if @post.update_attributes(params[:post])
        redirect_to @post
      else
        render 'edit'
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path
    end
    
    def check
      @post = current_user.posts.build(params[:post])
      respond_to do |format|
        if @post.valid?
          format.json { render :json => @post }
        else
          format.json { render :json => @post.errors.messages, :status => :unprocessable_entity }
        end
      end
    end
    
  end
end
