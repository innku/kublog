Kublog::Engine.routes.draw do
  root  :to => 'posts#index'
  resources :posts do
    collection do
      post :check
    end
  end
  resources :images
  resources :categories
  
  match '/:post_slug' => redirect("/kublog/posts/%{post_slug}"), :as => 'quickie'
end
