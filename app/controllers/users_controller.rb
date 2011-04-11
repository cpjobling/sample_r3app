class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample Rails 3 Application!"
      redirect_to @user
    else
      @title = "Sign up"
      # Reset password fields
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit Profile"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit Profile"
      render 'edit'
    end
  end

end
