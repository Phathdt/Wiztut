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
      resources :profiles, only: [:index, :show, :create, :update] do
        get '/ratings',to: 'ratings#index'
      end
      resources :course_posts, only: [:index, :show, :create, :update, :destroy]
      resources :teacher_posts, only: [:index, :show, :create, :update, :destroy]
      resources :courses, only: [:index, :show, :create, :update, :destroy]
      resources :ratings, only: [:create, :destroy]
      resources :conversations, only: [:create, :destroy]
    end
  end
end
