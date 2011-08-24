Rails.application.routes.draw do
  
  root :to => 'kublog/posts#index'
  
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/register', :to => 'users#new'
  
  resources :sessions
  resources :users
  
  mount Kublog::Engine => "/blog(.:format)"
end
