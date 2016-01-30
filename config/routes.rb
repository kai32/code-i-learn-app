Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  post '/rate' => 'rater#create', :as => 'rate'
  resources :categories do
    get 'recents'
    get 'featured'
    post 'follow'
    delete 'unfollow'
  end
  resources :articles do
      post 'comment', to: 'comments#create'
      post 'favourite', to: 'users#favourite'
      delete 'favourite', to: 'users#unfavourite'
    collection do
      get 'featured'
      # get 'recents', as: :recent
      patch 'toggle_feature'
      get 'favourites', to: 'users#favourite_articles', as: 'favourite'
    end
  end
  root 'home#index'
  get 'about', to: 'home#about'
  
  devise_scope :user do
       get 'upload_profile_pic', to: 'registrations#upload_avatar'
       post 'set_avatar', to: 'registrations#set_avatar'
  end
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :index, :destroy] do 
    post 'follow', to: 'users#follow'
    delete 'unfollow', to: 'users#unfollow'
    get 'followers'
    get 'followings'
  end
  
  resources :comments, only: [:show]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
