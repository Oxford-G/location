Rails.application.routes.draw do
  root to: 'users#sign_in'
  get 'log-in', to: 'session#log_in'
  get 'log-out', to: 'session#log_out'
  resources :followings
  resources :users
  resources :locates, only: [:create, :index, :show, :new]
  get '/recovery', to: 'users#recovery'
  get '/username', to: 'users#_get_username'
  delete '/unfollow', to: 'followings#unfollow'
end
