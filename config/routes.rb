Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  resources :users
  resources :password_recoveries
  match "/identificar" => "sessions#create"
  match "/entrar" => "sessions#new", as: :login
  match "/auth/:provider/callback" => "sessions#create_with_omniauth"
  match "/salir" => "sessions#destroy", :as => :logout
  match "/entrar/:id" => "sessions#new", :as => :auth
  match "/auth/failure" => "sessions#failure"
  # Backdoors used in test and development
  unless Rails.env.production?
    match "/enter/:id" => "sessions#enter" 
    match "/visitar/:id" => "library#enter"
  end

  root to: "dashboards#site"
  resources :references
  resources :libraries, path: '', concerns: :library
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
