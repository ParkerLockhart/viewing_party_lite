Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: [:index, :show, :create] do
    get '/discover', to: 'users#discover'
    post '/movies', to: 'movies#index'
    resources :movies, only: [:index, :show] do
      get '/viewing-party/new', to: 'parties#new'
      post '/viewing-party/new', to: 'parties#create'
    end
  end

  get '/register', to: 'users#new'

end
