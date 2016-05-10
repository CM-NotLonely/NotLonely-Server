Rails.application.routes.draw do
  
    get 'show/:id' => 'user#show'
    post 'register' => 'user#create'
    get 'show_my_information' => 'user#show_oneself'
    post 'login' => 'session#create'
    delete 'sign_out' => 'session#destroy'
    
    patch 'update_head_image' => 'user#update_head_image'
    patch 'update_password' => 'user#update_password'
    patch 'update' => 'user#update'

    resources :groups do 
      resources :activities do
        resources :likes do
        end
      end
    end

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

    match '/group', to: 'groups#index2', via: 'get' 
    match '/activities/:activity_id/likes', to: 'likes#create', via: 'post' 
    match '/activities/:activity_id/likes', to: 'likes#destroy', via: 'delete'
    match '/top10_groups', to: 'groups#index3', via: 'get' 
    match '/top10_activities', to: 'activities#index2', via: 'get' 

    post 'follow/create/:user_followed_id' => 'follow#create'
    delete 'follow/destroy/:id' => 'follow#destroy' 
    get 'follow/index' => 'follow#index'

end
