class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :check, only: [:edit]

  def index
      @book = Book.new
      @books = Book.all
      @users = User.all
      @user = User.find(current_user.id)
  end

  def show
      @book_new = Book.new
      @book = Book.find(params[:id])
      @user = @book.user
  end

  def create
  	  @book = Book.new(book_params)
      @books = Book.all
  	  @book.user_id = current_user.id
  	  if  @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to book_path(@book)
      else
        @user = current_user
        render 'index'
    end
  end

  def edit
      @book = Book.find(params[:id])
      @user = @book.user
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
  end

  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
      flash[:notice] = "Book was successfully upddated."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
end

  private
  		def book_params
  			params.require(:book).permit(:title,:body, :profile_image_id)
  		end

  def check
      book = Book.find(params[:id])
      user = User.find(book.user_id)
      redirect_to books_path unless current_user == user
  end

end