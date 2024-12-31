Rails.application.routes.draw do
  resources :todos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
   root "welcome#index"
  get "/welcome" => "welcome#index"

  namespace "api" do
    namespace "v1" do
      resources :todos, except: [:new, :edit] do
        patch :updated_completed, on: :member
      end
    end
  end
end
