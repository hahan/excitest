Learnbird::Application.routes.draw do
  get "password_resets/new"
  resources :user_cards
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  root  'static_pages#home'
  match '/public_card', to: 'user_cards#public_card', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/newcard', to: 'user_cards#new', via: 'get'
  match '/flash_cards', to: 'user_cards#flash_cards', via: 'get'
  match '/search_cards', to: 'user_cards#search', via: 'get'
  match '/deletecard', to: 'user_cards#delete', via: 'delete'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

end
