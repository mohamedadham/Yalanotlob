Rails.application.routes.draw do
  get 'invitations/update'
  devise_for :users
  get 'invitation/update'
  mount Notifications::Engine => "/notifications"
  resources :invitations
  resources :group_members
  resources :order_details
  resources :orders
  resources :friends
  resources :groups
  resources :users
  root :to => "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
