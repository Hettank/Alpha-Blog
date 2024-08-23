Rails.application.routes.draw do
  root "articles#home"
  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get 'signup', to: 'users#new'
  resources :users, expect: [:new]   

  # login is not regular resourceful route it won't hit the database so we have to manually create the route
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
  