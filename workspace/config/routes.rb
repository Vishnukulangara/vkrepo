Rails.application.routes.draw do
  require 'resque/server'
  get 'employee_dashboard/index'

  get 'sessions/create'

  get 'sessions/destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  

  get 'home/index'
  resources :admins
  resources :companies
  resources :admin_users
  resources :employees
  resources :admin_assets
  resources :messages
  resources :newsletters
  get 'messages/archive/:id' => 'messages#archive'
  get 'messages/unarchive/:id' => 'messages#unarchive'
  get 'messages/to_employee/:id' => 'messages#to_employee'
  post 'messages/send_msg/:id' => 'messages#send_msg'
  get 'home/password_change' => 'home#password_change'
  post 'admins/search_employee' => 'admins#search_employee'
  post 'employee_dashboard/search_employee' => 'employee_dashboard#search_employee'
  get 'admins/edit_password/:id' => 'admins#edit_password'
  patch 'admins/update_password/:id' => 'admins#update_password'
  get 'employee_dashboard/profile/:id' => 'employee_dashboard#profile'
  get 'employee_dashboard/show_asset/:id' => 'employee_dashboard#show_asset'
  get 'employee_dashboard/employee_asset' => 'employee_dashboard#employee_asset'
  get 'employee_dashboard/edit/:id' => 'employee_dashboard#edit'
  patch 'employee_dashboard/update/:id' => 'employee_dashboard#update'
  get 'employees/compose_mail/:id' => 'employees#compose_mail'
  post 'employees/send_mail/:id' => 'employees#send_mail'
  devise_for :users 
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  mount Resque::Server.new, at: "/resque"
  

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
