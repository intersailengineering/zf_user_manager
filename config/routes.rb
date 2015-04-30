ZfUserManager::Engine.routes.draw do

  get '/user_manager', to: redirect('/user_manager/users')

  get '/user_manager/users', to: '/intersail/zf_user_manager/user#index'
  get '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#show'
  post '/user_manager/users', to: '/intersail/zf_user_manager/user#create'
  put '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#update'
  delete '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#destroy'
  post '/user_manager/users/:id/add_profile', to: '/intersail/zf_user_manager/user#add_profile'
  post '/user_manager/users/:id/destroy_profile/:profile_id', to: '/intersail/zf_user_manager/user#destroy_profile'

end
