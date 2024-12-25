Rails.application.routes.draw do
  root to: 'home#index'

  resources :sessions, only: [ :create ]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  post 'authenticate', to: 'authentication#authenticate'
end
