Hsahara::Application.routes.draw do

  get "home/pie_chart_data", :as => :pie_chart_data

  get "home/bar_chart_data", :as => :bar_chart_data

  put "rooms/unblock_room", :as => :unblock_room

  put "rooms/block_room", :as => :block_room

  get "service_items/:id" => "service_items#get_service_item"

  delete "line_items/:id" => "line_items#delete_line_item", :as => "delete_line_item"

  put "line_items/:id" => "line_items#edit_line_item", :as => "edit_line_item"

  get "line_items/:id" => "line_items#get_line_items", :as => "line_item"

  post "service_items/add_service", :as => "add_service"

  delete "service_items/delete_service", :as => "delete_service"

  post "payments/add_payment", :as => "add_payment"

  delete "payments/delete_payment", :as => "delete_payment"

  put "checkins/shift_room", :as => "shift_room"

  devise_for :admins

  devise_for :users

  resources :services

  resources :companies

  get "home/index", :as => "user_root"

  get "home/login"

  get "home/send_report"

  put "checkins/split_room" => "checkins#split_room", :as => "split_room"

  match "/admin" => "home#admin", :as => "admin_root"

  get "/checkout/:id" => "checkins#checkout"

  resources :checkins

  resources :rooms

  resources :room_types

  resources :guests

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#login"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
