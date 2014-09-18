Rails.application.routes.draw do

  resources :line_items
  resources :carts
  resources :products
  resources :notifications
  resources :orders
  resources :line_orders
  #get 'orders/index'
  get "products/file_download/:id" => "products#file_download"
  get "/cities_by_state" => "cities#cities_by_state"
  get 'welcome/index'
  get 'welcome/aboutUs'
  get 'welcome/security'
  get 'welcome/checkout/:id' => 'welcome#checkout'
  #get 'welcome/checkout'
  get 'welcome/save'
  get 'welcome/myProducts'
  get 'welcome/pag'
  get '/user_products/:id' => 'welcome#products'
  get '/welcome/down_prod/order/:id' => 'welcome#down_prod'

  post '/notification' => 'welcome#notification'
  get '/redirect/:id' => 'welcome#redirect'

  devise_for :users, controllers: {registrations: 'registrations'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
