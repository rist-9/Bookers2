class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
      @book = Book.new
      @users = User.all
      @user = User.find(current_user.id)
      # @user current_user.id
  end

  def show
  	  @book = Book.new
      @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
      if current_user.id != @user.id
      redirect_to user_path(current_user)
      end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
      # redirect_to user_path
    else
      render :edit
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
