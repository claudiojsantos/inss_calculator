Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        resources :applicants, only: [ :index, :show ] do
        resources :addresses, only: [ :create, :update, :destroy ]
        resources :contacts, only: [ :create, :update, :destroy ]
      end
    end
  end

  root to: 'home#index'

  resources :sessions, only: [ :create ]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  post 'authenticate', to: 'authentication#authenticate'
end
