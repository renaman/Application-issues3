class FavoritesController < ApplicationController
	def create
		respond_to do |format|
			book = Book.find(params[:book_id])
			favorite = current_user.favorites.new(book_id: book.id)
			favorite.save
			redirect_to request.referer
			format.js
		end
	end

	def destroy
		respond_to do |format|
			book = Book.find(params[:book_id])
			favorite = current_user.favorites.find_by(book_id: book.id)
			favorite.destroy
			redirect_to request.referer
			format.js
		end
	end

end
