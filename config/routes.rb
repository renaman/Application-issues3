Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  resources :users, only: [:show,:index,:edit,:update] do
  	resource :relationships, only: [:create, :destroy]
  	get 'follows' => 'relationships#follower', as: 'follows'
  	get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
  end
  get 'search/search'
  root 'home#top'
  get 'home/about'
end
