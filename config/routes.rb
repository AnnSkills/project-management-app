Rails.application.routes.draw do
  resources :projects

  root "home#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :projects


  scope controller: :static do
    get :pricing
  end
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  get "success", to: "checkouts#success"
end
