Rails.application.routes.draw do
  
  root :to => 'sessions#new'
  
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/register', :to => 'users#new'
  
  resources :sessions
  resources :users
  
  mount Kublog::Engine => "/kublog(.:format)"
end
