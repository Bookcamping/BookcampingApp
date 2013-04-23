require 'sidekiq/web'


Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  resources :users do
    get :activity, on: :member
    resources :notifications, only: :index
  end
  match 'timeline', to: 'users#timeline', as: :timeline

  resources :versions
  resources :shelf_items, except: :index
  resources :licenses
  resources :comments
  resources :followings
  resources :tags
  resources :references do
    [:tag, :publish, :coverize].each do |action|
      get action, on: :member
    end
    get :autocomplete_reference_title, :on => :collection
    resources :versions, only: :index
    resources :reviews
    resource :repub
    resources :downloads
    resources :links
    resources :shelf_items, only: :index
  end
  resources :links, only: :show
  match '/download/*title', to: 'downloads#fetch',
    as: :download, format: false

  resources :libraries
  resources :recommendations
  resources :notifications, only: :index

  resources :password_recoveries, path: 'recuperar', except: [:index] do
    post :change, on: :collection
  end
  match '/recuperar/token/:id' => 'password_recoveries#recover', as: 'recovery'

  # Dashboards
  match "/buscar" => "dashboards#search", as: :search
  match "/buscar/:term" => "dashboards#search"
  match "/portada/" => "dashboards#welcome"
  get '/publicadas' => 'dashboards#published'
  get '/destacadas' => 'dashboards#featured_shelves'

  match "/identificar" => "sessions#create"
  match "/entrar" => "sessions#new", as: :login
  post "/login_from_complete_registration" => "sessions#login_from_complete_registration"
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
  mount Sidekiq::Web, at: '/sidekiq'

  root to: "dashboards#welcome"
  WaxMuseum::Routes.draw

  scope ':library' do #, :constraints => LibraryConstraints.new do
    #root to: 'shelves#index'
    resources :shelves, path: '' do #, except: :index do
      resources :versions, only: :index
      resources :references
    end
  end
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
