Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  resources :references
  resources :memberships
  resources :users
  resources :versions
  resources :password_recoveries
  resources :shelves, only: [:show]
  resources :shelf_items, only: [:show]
  resources :licenses
  resources :comments
  match "/identificar" => "sessions#create"
  match "/entrar" => "sessions#new", as: :login
  match "/auth/:provider/callback" => "sessions#create_with_omniauth"
  match "/salir" => "sessions#destroy", :as => :logout
  match "/entrar/:id" => "sessions#new", :as => :auth
  match "/auth/failure" => "sessions#failure"
  # Backdoors used in test and development
  unless Rails.env.production?
    match "/enter/:id" => "sessions#enter", as: :enter
    match "/visitar/:id" => "library#enter", as: :visit_library
  end

  root to: "dashboards#site"
  WaxMuseum::Routes.draw
  resources :libraries, path: '', concerns: :library
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
