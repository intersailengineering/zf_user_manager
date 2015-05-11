ZfUserManager::Engine.routes.draw do

  get '/user_manager', to: redirect('/user_manager/users')

  # Users
  get '/user_manager/users', to: '/intersail/zf_user_manager/user#index'
  get '/user_manager/users/new', to: '/intersail/zf_user_manager/user#new'
  get '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#show'
  post '/user_manager/users', to: '/intersail/zf_user_manager/user#create'
  put '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#update'
  delete '/user_manager/users/:id', to: '/intersail/zf_user_manager/user#destroy'

  # Units
  get '/user_manager/units', to: '/intersail/zf_user_manager/unit#index'
  get '/user_manager/units/:id', to: '/intersail/zf_user_manager/unit#show'
  post '/user_manager/units', to: '/intersail/zf_user_manager/unit#create'
  put '/user_manager/units/:id', to: '/intersail/zf_user_manager/unit#update'
  delete '/user_manager/units/:id', to: '/intersail/zf_user_manager/unit#destroy'

  # Roles
  get '/user_manager/roles', to: '/intersail/zf_user_manager/role#index'
  get '/user_manager/roles/:id', to: '/intersail/zf_user_manager/role#show'
  post '/user_manager/roles', to: '/intersail/zf_user_manager/role#create'
  put '/user_manager/roles/:id', to: '/intersail/zf_user_manager/role#update'
  delete '/user_manager/roles/:id', to: '/intersail/zf_user_manager/role#destroy'

  # Acls
  get '/user_manager/acls', to: '/intersail/zf_user_manager/acl#index'
  get '/user_manager/acls/:id', to: '/intersail/zf_user_manager/acl#show'
  post '/user_manager/acls', to: '/intersail/zf_user_manager/acl#create'
  put '/user_manager/acls/:id', to: '/intersail/zf_user_manager/acl#update'
  delete '/user_manager/acls/:id', to: '/intersail/zf_user_manager/acl#destroy'

  # Urrs
  get '/user_manager/urrs/new', to: '/intersail/zf_user_manager/urr#new'
  post '/user_manager/urrs/update_all', to: '/intersail/zf_user_manager/urr#update_all'
  delete '/user_manager/urr/:id', to: '/intersail/zf_user_manager/urr#destroy'
end
