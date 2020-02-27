Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  post 'follow/:id' => 'relationships#create', as: 'post_follow'
  delete 'unfollow/:id' => 'relationships#destroy', as: 'destroy_follow'

  devise_for :users

  # resource :relationships, only: [:create,:destroy]
  
  resources :users , only: [:index,:edit,:show,:update] do
    member do
      get 'favorites' => 'users#favorites'
      get 'following' => 'users#following'
      get 'follower' => 'users#follower'
    end
  end

  resources :books do
    resource :book_comments, only: [:create,:update,:destroy]
    resource :favorites, only: [:create,:destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
