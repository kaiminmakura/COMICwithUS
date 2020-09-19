Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users

	root to: 'homes#top'

  get 'comics/total_ranking'
  resources :comics, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :admin_comics, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  resources :tags do
    get 'comics', to: 'comics#search'
  end

  get 'users/reviewer_ranking'
  resources :users, only: [:show]
  resources :admin_users, only: [:index, :show]

  resources :reviews, only: [:create, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :admin_reviews, only: [:destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
