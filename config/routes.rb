Rails.application.routes.draw do
  root 'welcome#index'
  # devise_for :users
  namespace :api do
    namespace :v1 do
      post '/users/sign_up', to: 'registrations#create'
      patch '/users', to: 'registrations#update'
      delete '/users', to: 'registrations#destroy'
      post '/users/sign_in', to: 'sessions#create'
      delete '/users/sign_out', to: 'sessions#destroy'
    end
  end
end
