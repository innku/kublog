Kublog::Engine.routes.draw do
  root  :to => 'posts#index'
  resources :posts do
    resources :comments
    collection do
      post :check
    end
  end
  resources :images
  resources :categories
  match '/:id', :to => 'posts#show', :as => 'quickie'
end
