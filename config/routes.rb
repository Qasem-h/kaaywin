Kaaywin::Application.routes.draw do
  
  get "tickets/index"
  get "tickets/show"
  get "tickets/print"
  get "tickets/cancel"
  get "tickets/destroy"
  get "grid_test/test"
  get "betting/index"
  get "bets/destroy"
  get "sports/new"
  get "sports/edit"
  get "sports/create"
  get "sports/update"
  get "sports/destroy"
  get "events/new"
  get "events/index"
  get "events/edit"
  get "events/update"
  get "events/destroy"
  get "leagues/new"
  get "leagues/create"
  get "leagues/distroy"
  get "leagues/index"
  get "main/index"
  get "events/display/:id", to: 'events#show', as: 'display_event'
    get "tickets/display/:id", to: 'tickets#show', as: 'display_ticket'
  get "events/results" , to:'events#results', as: 'results'
   get "leagues/events/:id" , to:'events#index', as: 'league_events'
  get "/leagues/:id", to: 'leagues#index', as: 'sport_leagues'
  get "leagues/", to: 'leagues#index', as: 'back_to_sport_leagues'
  get "/events/enter_empty_results", to: "events#enter_empty_results", as: "empty_results"
 post "events/search"
 post "events/search_by_id"
  post "events/addbet"


 get "/betting/test_image", to: 'betting#test_image', as: 'test_image'
   get "/betting/:id", to: 'betting#placebet', as: 'placebet'
   post '/betting/reset_bet_slip', to: 'betting#reset_bet_slip', as:'reset_bet_slip'
    post '/betting/update_stake', to: 'betting#update_stake', as:'update_stake'
    post '/betting/issue_ticket', to: 'betting#issue_ticket', as: 'issue_ticket'

   post "/betting/remote_bet/:id", to: 'betting#remove_bet', as: 'remove_bet'

  get "events/:id", to: 'events#enter_result', as: 'result'
  post "events/placebet"
  post "events/new"
  patch "events/save_result/:id", to:'events#save_result', as: 'save_result'
    post "events/save_results", to:'events#save_results', as: 'save_results'
  #post "events/removebet"
 

  resources :users
  resource :results
  resources :leagues
  resources :bet_types

  resources :events do
    member do
      put 'save_result'
    end
  end

  resources :tickets
  resources :sports
  resources :bets
  resources :sessions, only: [:new, :create, :destroy]

  get "users/new"
  root 'admin#home'
  match '/contact', to: 'admin#contact', via: 'get'
  match '/about', to: 'admin#about', via: 'get'
  match '/register', to: 'users#new', via: 'get'
  #match '/event/removebet', to: 'event#removebet', via: 'delete'



  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

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
