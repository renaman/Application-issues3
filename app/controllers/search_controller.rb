class SearchController < ApplicationController
  def search
  	@model = params["search"]["model"]
  	@content = params["search"]["content"]
  	@how = params["search"]["how"]
  	if @model == 'user'
  	   @users = User.search(@content, @model, @how)
  	elsif @model = 'book'
  		p '-----book------'
  		@books = Book.search(@content, @model, @how)
  	end
  	p '------------'
  	p @books
  end
 end