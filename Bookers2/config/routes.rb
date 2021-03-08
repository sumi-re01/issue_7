Rails.application.routes.draw do
   root to: "homes#top"
   get 'home/about' => "homes#about"

   devise_for :users

   resources :users, only: [:show, :index, :update, :edit]
   resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
   end

   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end