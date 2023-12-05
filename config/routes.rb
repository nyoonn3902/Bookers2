Rails.application.routes.draw do
  devise_for :users
   resources :users, only: [:show, :edit, :index, :new, :update, :create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings',as: 'followings'
    get 'followers' => 'relationships#followers',as: 'followers'
   end
   resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, omly: [:create, :destroy]
   end
   root to: "homes#top"
   get 'home/about' => "homes#about",as: 'about'
   get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
