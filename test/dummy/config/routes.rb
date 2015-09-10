Rails.application.routes.draw do
  root to: 'intersail/zf_user_manager/user#index'

  mount ZfUserManager::Engine => '/'
  #@jtodoIMP put this as zum dependency
  mount IntersailAuth::Engine => '/'
end
