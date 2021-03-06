class UsersController < ApplicationController
    # Book.new =>@book_newで統一。

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
       redirect_to user_path(current_user)
    else
       render :edit
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image,
                                 :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

end
