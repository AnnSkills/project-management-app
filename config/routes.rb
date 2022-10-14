Rails.application.routes.draw do
  resources :projects

  root "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :projects

end
