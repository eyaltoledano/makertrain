Rails.application.routes.draw do

  get 'products/index'

  get 'products/new'

  get 'products/create'

  get 'products/show'

  get 'products/edit'

  get 'products/update'

  get 'products/destroy'

  root 'pages#home'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # get '/auth/twitter/callback' => 'sessions#create'
  get '/auth/github/callback' => 'sessions#create'
  get '/auth/producthunt/callback' => 'sessions#create'

  resources :users
  get '/dashboard' => 'users#dashboard'
  get '/signup' => 'users#new'

  resources :products
  resources :versions
  resources :tasks

end
