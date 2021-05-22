Rails.application.routes.draw do
  resources :users do
    post 'login', on: :collection
  end

  namespace :admins do
    resources :users
  end
end
