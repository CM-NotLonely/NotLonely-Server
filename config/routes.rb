Rails.application.routes.draw do
    # get 'picture/new' => 'picture#new'
    # post 'picture/create' => 'picture#create'
    # get 'picture/show' => 'picture#show'
    #修改了资源式路径，减少了不必要的请求参数。
    controller :user do
      get 'show'
      post 'create'
      post 'update'
    end

    post 'session/create' => 'session#create'
    get 'session/destroy' => 'session#destroy'

    resources :groups do # added by msl
      resources :activities do # added by msl
        resources :likes # added by msl
      end # added by msl
    end # added by msl

    resources :group_apply do
      member do
        get 'sub_index'
      end
    end

    resources :group_invite do
      member do
        get 'sub_index'
      end
    end
    
    resources :activity_apply do
      member do
        get 'sub_index'
      end
    end

    match '/groups', to: 'groups#index2', via: 'get' # added by msl
    match '/group', to: 'groups#index', via: 'get' # added by msl
    match '/activities/:activity_id/likes', to: 'likes#create', via: 'post' # added by msl
    match '/activities/:activity_id/likes', to: 'likes#destroy', via: 'delete' # added by msl
    match '/top10_groups', to: 'groups#index3', via: 'get' # added by msl
    match '/top10_activities', to: 'activities#index2', via: 'get' # added by msl

    post 'follow/create/:user_followed_id' => 'follow#create'
    get 'follow/destroy/:id' => 'follow#destroy' 
    get 'follow/index' => 'follow#index'

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
