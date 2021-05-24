Rails.application.routes.draw do
  resources :users do
    post 'login', on: :collection
    post :add_device_info, on: :collection
    resources :notes
  end

  namespace :admins do
    resources :users do
      resources :notes
    end
  end
end
