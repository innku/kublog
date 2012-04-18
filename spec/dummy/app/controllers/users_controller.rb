class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      self.kublog_current_user = @user
      redirect_to kublog_path, :notice => 'User registered successfully'
    else
      render 'new'
    end
  end
  
end
