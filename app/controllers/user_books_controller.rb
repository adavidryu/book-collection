class UserBooksController < ApplicationController
  before_action :set_user_book, only: %i[ show edit update destroy ]

  def index
    @user_books = UserBook.all
  end

  def show
  end

  def new
    @user_book = UserBook.new
  end

  def edit
  end

  def create
    @user_book = UserBook.new(user_book_params)

    if @user_book.save
      redirect_to @user_book, notice: "User book was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @user_book.update(user_book_params)
      redirect_to @user_book, notice: "User book was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user_book.destroy!
    redirect_to user_books_path, notice: "User book was successfully destroyed.", status: :see_other
  end

  private
    def set_user_book
      @user_book = UserBook.find(params.expect(:id))
    end

    def user_book_params
      params.expect(user_book: [ :user_id, :book_id ])
    end
end
