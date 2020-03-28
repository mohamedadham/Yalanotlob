Rails.application.routes.draw do
  resources :invitations
  resources :group_members
  resources :order_details
  resources :orders
  resources :friends
  resources :groups
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
