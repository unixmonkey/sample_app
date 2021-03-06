class UsersController < ApplicationController
  # Called before_action in rails 4
  before_filter :signed_in_user, only: [:edit, :update]
  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
  end
   def create
    @user = User.new(params[:user])    # Not the final implementation! ??? Maybe it is.
    if @user.save
      sign_in @user # When signup, if successful, also signin.
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # I don't really know why this works.....
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user

    else 
      render 'edit'
    end
  end


  def destroy
    sign_out
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    def signed_in_user
      # Same as: 
      # unless signed_in?
      # flash[:notice] = "Please sign in."
      # redirect_to signin_url
      # end
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end


end

