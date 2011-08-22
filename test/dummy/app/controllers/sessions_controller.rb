class SessionsController < ApplicationController
  
  def new
    redirect_to current_user if signed_in?
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user.authenticate(params[:password])
      self.current_user = @user 
      redirect_to @user, :notice => 'logged in successfully'
    else
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, :notice => 'Logged out successfully'
  end
  
end
