class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => 'User was created successfully'
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
end
