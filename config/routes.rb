Rails.application.routes.draw do
  root "home#index"
  resources :projects
  devise_for :accounts, controllers:{
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    invitations: 'users/invitations'
  }
  get "pricing", to:"prices#index"
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  post "subscription", to: "subscription#create_subscription"
  delete "subscription", to: "subscription#destroy"
  get "success", to: "checkouts#success"
  get 'accounts', to: 'accounts#show'
end
