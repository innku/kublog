module Kublog
  class NotificationsController < ApplicationController
    
    def preview
      @post = Post.new(params[:post])
      @preview = Notification.email_template(@post)
      respond_to do |format|
        format.json { render :json => {:preview => @preview }}
      end
    end
    
  end
end
