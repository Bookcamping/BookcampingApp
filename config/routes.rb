Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  constraints subdomain: /.+/ do
    match '', to: 'dashboards#library'
  end

  resources :memberships
  resources :users do
    get :activity, on: :member
    resources :notifications, only: :index
  end
  match 'timeline', to: 'users#timeline', as: :timeline

  resources :versions
  resources :shelf_items, except: :index
  resources :licenses
  resources :comments
  resources :subscriptions
  resources :tags
  resources :references do
    get :tag, on: :member
    resources :versions, only: :index
    resources :reviews
    resource :repub
    resources :downloads
  end
  match '/download/*title', to: 'downloads#fetch', 

    as: :download, format: false
  resources :libraries
  resources :recommendations
  resources :followings
  resources :notifications, only: :index

  resources :password_recoveries, path: 'recuperar', except: [:index] do
    post :change, on: :collection
  end
  match '/recuperar/token/:id' => 'password_recoveries#recover', as: 'recovery'

  # Email routes
  match "/email/activity/:id" => "emails#activity"
  match "/email/test" => "emails#test"
  match "/email/notifications" => "emails#notifications"

  # Dashboards
  match "/buscar" => "dashboards#search", as: :search
  match "/buscar/:term" => "dashboards#search"

  match "/identificar" => "sessions#create"
  match "/entrar" => "sessions#new", as: :login
  match "/auth/:provider/callback" => "sessions#create_with_omniauth"
  match "/salir" => "sessions#destroy", :as => :logout
  match "/entrar/:id" => "sessions#new", :as => :auth
  match "/auth/failure" => "sessions#failure"
  match "/mapa" => "site#map"

  # BLOG REDIRECT
  match "/blog/*post", to: redirect("http://blog.bookcamping.cc")
  match "/blog", to: redirect("http://blog.bookcamping.cc")
  match "/blog.atom", to: redirect("http://blog.bookcamping.cc/rss")

  # Backdoors used in test and development
  match "/enter/:id" => "sessions#enter", as: :enter

  root to: "dashboards#site"
  WaxMuseum::Routes.draw

  scope ':library' do #, :constraints => LibraryConstraints.new do
    resources :shelves, path: '' do
      resources :versions, only: :index
      resources :references
    end
  end
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
