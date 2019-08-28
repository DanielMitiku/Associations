Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

#  get 'users/new'
#  get 'users/create'
#  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/signup', to: 'users#new'
  resources :users
  
  resources :events
  root 'events#index'
end
