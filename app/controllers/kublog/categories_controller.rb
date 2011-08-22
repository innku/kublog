module Kublog
  class CategoriesController < ApplicationController
    
    skip_filter :require_admin, :only => [:show]
    
    def show
      @presenter = PostsPresenter.new(Category.find(params[:id]))
      respond_to do |format|
        format.atom { render :layout => false }
        format.rss  { redirect_to posts_path(:format => :atom), :status => :moved_permanently }
        format.html { render "#{root_path}posts/index" }
      end
    end
    
    def create
      @category = Category.new(params[:category])
      respond_to do |format|
        if @category.save
          format.json { render :json => @category }
        else
          format.json { render :json => @category.errors.messages, :status => 'unprocessable_entity' }
        end
      end
    end
    
    def update
      @category = Category.find(params[:id])
      respond_to do |format|
        if @category.update_attributes(params[:category])
          format.json { render :json => @category }
        else
          format.json { render :json => @category.errors.messages, :status => 'unprocessable_entity' }
        end
      end
    end
    
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      respond_to do |format|
        format.json{ render :json => @category }
      end
    end
    
  end
end
