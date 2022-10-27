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
  scope controller: :static do
    get :pricing
  end
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  post "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  get "success", to: "checkouts#success"
  get 'accounts', to: 'accounts#show'
end
