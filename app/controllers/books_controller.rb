class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @post_book = Book.new
  end

  def index
    @post_book = Book.new
    @post_books = Book.all
    @user = current_user
  end

  def show
    @post_book = Book.new
    @post_book_detail = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @post_book_detail.user
  end

  def create
    @post_book = Book.new(post_book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post_book.id)
    else
      @user = current_user
      @post_books = Book.all
      render :index
    end

  end

  def destroy
    post_book = Book.find(params[:id])
    post_book.destroy
    redirect_to books_path
  end

  def edit
    @post_book = Book.find(params[:id])
  end

  def update
    @post_book = Book.find(params[:id])
    if @post_book.update(post_book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@post_book)
    else
      render :edit
    end
  end

  private

  def post_book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    post_book = Book.find(params[:id])
    user = post_book.user_id
    unless user == current_user.id
      redirect_to books_path
    end
  end
end
