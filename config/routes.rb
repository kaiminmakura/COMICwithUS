Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users

	root to: 'homes#top'
	get 'admin_homes/top'

	resources :comics, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :admin_comics, only: [:new, :create, :index, :show, :edit, :update, :destroy]

    resources :users, only: [:show]
    resources :admin_users, only: [:show]

    resources :reviews

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
