Habitapp::Application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  devise_for :users, controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  resources :habits
  resources :checkins
end
