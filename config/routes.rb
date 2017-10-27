Quizapp::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/list' => 'users#index'
    get 'users/report' => 'users#report'
    get 'users/:id' => 'users#show'
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users

  get 'trainers/logo' => 'trainers#logo', :via => :get
  resources :trainers
  get 'trainers/:id/crop' => 'trainers#crop'
  post 'trainers/:id/cropped_image' => 'trainers#cropped_image'
  get 'trainers/:id/remove_logo' => 'trainers#remove_logo'

  resources :documents, only: %i[index new create destroy]

  get 'documents/index'

  get 'documents/new'

  get 'documents/create'

  get 'documents/destroy'

  root 'home#page'

  get 'home/page'

  get 'home/support_contact'

  get 'home/about'

  get 'questions/list'
  get 'questions/setting' => 'questions#setting', :via => :get
  post 'questions/save_setting' => 'questions#save_setting', :via => :post
  resources :questions

  get 'quiz/index'

  post 'quiz/start'

  get 'quiz/question'

  post 'quiz/question'

  post 'quiz/answer'

  get 'quiz/result'

  post 'choices/create'

  post 'choices/destroy'

  post 'reporter/create'

  get 'reporter/index'

  get 'reporter/check'

  get 'reporter/list'

  post 'reporter/save'

  resource :candidates

  get 'candidates/synchronize'

  post 'candidates/refresh'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
