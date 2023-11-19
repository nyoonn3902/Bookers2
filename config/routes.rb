Rails.application.routes.draw do
  devise_for :users 
   resources :users, only: [:show, :edit]
   resources :books, only: [:new, :create, :index, :show]
   resources :homes, only: [:new, :create, :index, :show]
  root to: "homes#top"
  get 'top' => 'homes#top'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
