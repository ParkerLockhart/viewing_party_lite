Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/dashboard', to: 'users#show'
  get '/discover', to: 'users#discover'
  post '/movies', to: 'movies#index'
  get '/logout', to: 'sessions#destroy'

  resources :movies, only: [:index, :show] do
    get '/viewing-party/new', to: 'parties#new'
    post '/viewing-party/new', to: 'parties#create'
  end
  resources :users, only: [:create]

  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

end
