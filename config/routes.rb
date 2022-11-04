Rails.application.routes.draw do
  root "home#index"
  resources :projects
  resources :subscriptions, only: [:create, :destroy]
  resources :accounts, only: [:show]
  devise_for :accounts, controllers:{
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    invitations: 'users/invitations',
  }
  get "pricing", to:"prices#index", as: 'pricing'
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  get "success", to: "checkout#success" #rename
end
