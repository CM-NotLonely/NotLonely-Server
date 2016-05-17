Rails.application.routes.draw do
  
  #/////////////////////
  # For Users #
    get 'users/show/:id' => 'user#show'
    post 'users/register' => 'user#create'
    get 'users/show_my_information' => 'user#show_oneself'
    post 'users/login' => 'session#create'
    delete 'users/sign_out' => 'session#destroy'
    patch 'users/update_head_image' => 'user#update_head_image'
    patch 'users/update_password' => 'user#update_password'
    patch 'users/update' => 'user#update'

  #///////////////////////
  # For Groups #
    post 'groups' => 'groups#create'
    get 'groups/top/:number' => 'groups#top'
    get 'groups/:number' => 'groups#index'
    get 'groups/all/:number' => 'groups#all'
    get 'groups/:id' => 'groups#show'
    patch 'groups/:id' => 'groups#update'
    delete 'groups/:id' => 'groups#destroy'
  
  #//////////////////////
  # For Activities #
    post 'groups/:group_id/activities' => 'activities#create'
    post 'default/groups/activities' => 'activities#create_default'
    post 'groups/all_activities' => 'activities#all' 
    get 'groups/activities/top/:number' => 'activities#top'
    get 'groups/:group_id/activities/:id' => 'activities#show'
    patch 'groups/activities/:id' => 'activities#update'
    delete 'groups/activities/:activity_id' => 'activities#destroy'
    post 'groups/activities/:activity_id/likes' => 'likes#create'
    delete 'groups/activities/:activity_id/likes' => 'likes#destroy'
    
    
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
     

    post 'follows/create/:user_followed_id' => 'follow#create'
    delete 'follows/destroy/:id' => 'follow#destroy' 
    get 'follows/index' => 'follow#index'

end
