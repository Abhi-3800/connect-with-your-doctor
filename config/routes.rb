Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "hospitals#index"

  resources :hospitals, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:new, :create]
  resource :session
  resources :passwords, param: :token
  get 'nearby_hospitals', to: 'nearby_hospitals#index', as: :nearby_hospitals
  get 'nearby_hospitals/search', to: 'nearby_hospitals#search', as: :search_nearby_hospitals
  get 'nearby_hospitals/download_csv', to: 'nearby_hospitals#download_csv', as: :download_nearby_hospitals
end
