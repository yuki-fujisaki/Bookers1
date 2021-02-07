class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ３. トップ画面へリダイレクト
    if @book.save
     flash[:notice] = "Book was successfully created."
     redirect_to book_path(@book.id)
    else
     render action: :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
     flash[:notice] = "Book was successfully updated."
     redirect_to book_path(@book.id)
    else
     render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    if book.destroy
     flash[:notice] = "Book was successfully destroyed."
     redirect_to books_path
    else
     render("books/edit")
    end # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
