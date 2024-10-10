Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "camera_men#index"
  namespace :users_module do
    resources :camera_men
  end  
end
