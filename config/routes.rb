PosterJudging::Application.routes.draw do
    mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

    namespace :admin do
		resources :posters, :only => [:index] do
            collection { 
                post :import
                delete :clear
                get :download
                post :set_maximum
            }
        end
		resources :scores, :only => [:index, :show, :edit, :update, :destroy, :create] do
		    collection {
                 get :rankings
                 get :download_ranks
                 get :download_scores
                 
              }
        end

		resources :judges, :only => [:index, :destroy] do
			delete :clear, on: :collection
			post :create, on: :collection
		end
        root to: "admin#index"
        
		get :reset, controller: 'admin'  
		put :reset_pw, controller: 'admin'
		
		get "/register/:judge_id", to: 'admin#register', as: 'register'
		put "/register/:judge_id", to: 'admin#registerup', as: 'registerup'
	end
	
    resources :judges, :only => [:show, :update] do
        resources :scores, path: :posters, param: :poster_id, :only => [:edit, :update]{
			post :no_show
            get  :accept
            put :assign
	    }
        delete :leave
        get :register
    end

    resources :sessions, only: [:new, :create, :destroy] do
        get :download, on: :collection
        delete :signout, on: :collection
    end
    match '/signin', to: 'sessions#new', via: :get
    match '/signout', to: 'sessions#destroy', via: :delete
    match '/signout_check', to: "application#signout_check", via: :get
    root :to => 'sessions#new'
    
    resources :posters
	

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
