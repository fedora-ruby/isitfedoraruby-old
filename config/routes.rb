Isitfedoraruby::Application.routes.draw do

  root :to => 'home#show'

  get 'contribute' => 'static_pages#contribute'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  get 'rubygems/' => 'rubygems#index'
  get 'rubygems/all' => 'rubygems#index'
  # match 'rubygems/:id' => 'gemcomments#create', :via => :post

  get 'fedorarpms/all' => 'fedorarpms#index'
  # match 'fedorarpms/:id' => 'rpmcomments#create', :via => :post

  get 'searches/suggest_gems' => 'searches#suggest_gems'
  post 'searches/' => 'searches#redirect'
  get 'searches/:id' => 'searches#index'

  resources :fedorarpms, :constraints => { :id => /.*/ } do
    get :full_deps, :on => :member
    get :full_dependencies, :on => :member
    get :full_dependents,   :on => :member
    get :by_owner, :on => :member
    get :badge, :on => :member
    get :not_found, :on => :member
  end
  resources :rubygems, :constraints => { :id => /.*/ }
  #resources :searches

  resources :builds do
    get :import, :on => :collection
    post :import, :on => :collection
  end

  resources :stats, :constraints => { :id => /.*/ } do
    get :gemfile_tool, :on => :collection
    get :user_rpms
    get :timeline
    get :tljson
    get :user_rpms_data
    post :gemfile_tool, :on => :collection
  end

# unless Rails.application.config.consider_all_requests_local
    get '*not_found', to: 'errors#error_404'
#  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
