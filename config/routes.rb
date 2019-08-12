Rails.application.routes.draw do
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
  get '/review_tasks' => 'users#review'
  get '/claimed_tasks' => 'users#claimed'

  get '/products/:slug' => 'products#show'
  resources :products
  
  resources :versions
  resources :tasks

end
