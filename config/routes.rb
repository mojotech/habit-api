Habitapp::Application.routes.draw do
  get "habitapp/index"
  root to: "habitapp#index"

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  post 'send_password_reset', to: 'users#send_password_reset'
  post 'change_password', to: 'users#change_password'

  resources :habits
  resources :checkins
  resources :targets
  resources :users do
    collection do
      get :me
      patch :me
    end
  end
end
