Rails.application.routes.draw do
  root to: 'intersail/zf_user_manager/user#index'

  mount ZfUserManager::Engine => '/'
end
