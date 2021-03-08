class BooksController < ApplicationController
  # book詳細画面の新期投稿フォームにはBook.new,詳細にはBook.find(parama[:id])を入れたい
  # Book.new =>@book_newで統一。

  def show
    @book_new = Book.new
    @book_comment = BookComment.new

    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @user = current_user
    @book_new = Book.new
    @books = Book.all
  end
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new)
    else
      @user = current_user
      @books = Book.all
      # render先はいつもbooks#indexにいく。
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    else
      render"edit"
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
   @book = Book.find(params[:id])
   @book.destroy
   redirect_to books_path
  end


  private
   def book_params
     params.require(:book).permit(:title, :body)
   end


end
