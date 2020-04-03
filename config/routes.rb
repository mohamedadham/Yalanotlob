Rails.application.routes.draw do
  get '/friends/search/:input', to: 'friends#search'

  resources :invitations
  resources :group_members
  resources :order_details
  resources :orders
  resources :friends
  resources :groups
  resources :users

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
