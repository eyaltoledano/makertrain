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
  get '/portfolio' => 'users#owned_products'
  post '/claim' => 'tasks#claim'

  resources :products, param: :slug do
    get ':slug/new_version' => 'versions#new'
    resources :versions, param: :version_number do
      resources :tasks
      post 'new_task' => 'tasks#create'
    end
  end




end
