ZfUserManager::Engine.routes.draw do

  get '/user_manager', to: redirect('/user_manager/users')

  # Users
  get '/user_manager/users', to: '/intersail/zf_user_manager/user#index'
  get '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#show'
  post '/user_manager/users', to: '/intersail/zf_user_manager/user#create'
  put '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#update'
  delete '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#destroy'

  # Urrs
  get '/user_manager/users/:id/new_urr', to: '/intersail/zf_user_manager/urr#new'
  get '/user_manager/users/:id/update_urr/:urr_id', to: '/intersail/zf_user_manager/urr#update'
  get '/user_manager/users/:id/destroy_profile/:urr_id', to: '/intersail/zf_user_manager/urr#destroy'
end
