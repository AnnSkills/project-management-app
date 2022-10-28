Rails.application.routes.draw do
<<<<<<< HEAD
  root "home#index"
=======
  root "home#indexAccount"
>>>>>>> new
  resources :projects
  devise_for :accounts, controllers:{
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
<<<<<<< HEAD
    invitations: 'users/invitations'
=======
>>>>>>> new
  }
  scope controller: :static do
    get :pricing
  end
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  post "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  get "success", to: "checkouts#success"
<<<<<<< HEAD
  get 'accounts', to: 'accounts#show'
=======
>>>>>>> new
end
