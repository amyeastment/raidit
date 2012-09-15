Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :characters do
    member do
      put :make_main
    end
  end

  resources :users

  resources :sessions
  resource :profile, :controller => :profile

  resources :raids do
    resources :signups
  end

  resources :guilds

  match "/signups/:id/:command", :to => "signups#update", :as => "update_signup"

  match "/login", :to => "sessions#new", :as => "login"
  match "/logout", :to => "sessions#destroy", :as => "logout"
end
