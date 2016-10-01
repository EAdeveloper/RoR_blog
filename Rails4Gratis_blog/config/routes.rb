Rails.application.routes.draw do
  
  resources :categories
  #Nested resources
  resources :articles do
  	resources :comments, only: [:create, :destroy, :update]
  end
  devise_for :users
  root 'welcome#index'

  
  get "/dashboard", to: "welcome#dashboard"
  # To modify the resources that alredy exists
   # need use method PUT
  put "/articles/:id/publish", to: "articles#publish"


end
  
  # devise_for :users
 # get 'welcome/index'
 #post 'welcome/index'
 #get "special", to: "welcome#index"

 # resources :articles #resources; especifica todas la rutas
  #resources :articles, except: [:delete]
  #resources :articles, only: [:create, :show]

 	# get "/articles" 			index
 	# post "/articles" 			create
 	# delete "/articles/:id" 	destroy
 	# get "/articles/:id" 		show
 	# get "/articles/new" 		new
 	# get "/articles/:id/edit" 	edit
 	# patch "/articles/:id" 	update
 	# put  "/articles/:id"  	update

 # root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # end
