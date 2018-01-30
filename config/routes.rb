Rails.application.routes.draw do
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  resources :notifications
  # the page root
  root to:'microposts#index'

  # routes for Devise and Omniauth
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "omniauth_callbacks" }

  # routes for Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # routes for the API's
  namespace :api, defaults: {format: :json} do
    mount TolSkitSessions::Engine => "/"
    mount TolSkitSessionsFacebook::Engine => "sessions/facebook"
    mount TolSkitSessionsTwitter::Engine => "sessions/twitter"
    mount TolSkitSessionsInstagram::Engine => "sessions/instagram"

    resources :users
    resources :microposts do
      resources :comments
      member do
        post :like_unlike
      end
    end
  end

  # routes for locale change
  get 'sessions/:locale', to: "sessions#switch", as: :sessions
  
  # get 'microposts/users/:id/get_following', to: "users#get_following"

  # routes for Users
  resources :users do
    resources :microposts
    
    member do
      get :get_following
      get :get_followers
    end
    
    collection do
      get :all_users
    end
  end
  
  resources :microposts do
    collection do
      get 'search'
      get :browse
    end

    resources :comments do
      member do
        get :delete_comment
      end
    end

    member do
      get :like
      get :unlike
      get :like_unlike
      get :static_map
    end
  end
  


  # route for User Sign Out
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :signout
    
    authenticated :user do
      root 'microposts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'static_pages#home', as: :unauthenticated_root
    end

  end

  # routes for Omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  
  get ':user_name', to: 'users#show', as: :profile
  get ':user_name/edit', to: 'users#edit', as: :edit_profile 
  mount ActionCable.server => '/cable'
end
