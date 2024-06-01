class FavoritesController < ApplicationController
  before_action :set_book, only: [:create, :destroy]

  def create
    Favorite.create(user_id: current_user.id, book_id: @book.id)
    set_books
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id)
    @favorite.destroy
    set_books
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_books
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort { |a, b|
      b.favorites.where(created_at: from...to).size <=> a.favorites.where(created_at: from...to).size
    }
  end
end
