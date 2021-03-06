Rails.application.routes.draw do

  get '/friends/search/:input', to: 'friends#search'
  get '/friends/search-by-mail/:input', to: 'friends#searchByMail'
  get 'invitations/update'
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  get 'invitation/update'
  mount Notifications::Engine => "/notifications"
  resources :invitations
  resources :group_members
  resources :order_details, :except => [:index]
  resources :orders, :except => [:edit]
  resources :friends
  resources :groups
  resources :users
  root :to => "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
