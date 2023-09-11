class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @post_book = Book.new
    @post_books = @user.books
  end

  def index
    @user = current_user
    @post_book = Book.new
    @users = User.all
  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to new_user_session_path
    end
  end
end
