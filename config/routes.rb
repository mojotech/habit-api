Habitapp::Application.routes.draw do
  get "home/index"
  get "authenticated_user", to: 'home#authenticated_user'
  root to: "home#index"
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  post 'send_password_reset', to: 'home#send_password_reset'
  post 'change_password', to: 'home#change_password'
  resources :habits
  resources :checkins
  resources :targets
end
