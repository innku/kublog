module Kublog
  class CommentsController < ApplicationController
    
    skip_filter   :require_admin
    before_filter :set_comment_user, :only => [:create]
    
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(params[:comment])
      respond_to do |format|
        if @comment.save
          format.json { render :json => @comment}
        else
          format.json { render :json => @comment.errors.to_json, :status => :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.json{ render :json => @comment }
      end
    end
    
    private
    
    def set_comment_user
      if current_user
        params[:comment].merge!({:user => current_user})
      end
    end
    
  end
end
