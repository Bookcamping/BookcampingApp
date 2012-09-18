Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  resources :memberships
  resources :users
  resources :versions
  resources :shelf_items
  resources :licenses
  resources :comments
  resources :subscriptions
  resources :tags
  resource :activity
  resources :references
  resources :libraries

  resources :password_recoveries, path: 'recuperar', except: [:index] do
    post :change, on: :collection
  end
  match '/recuperar/token/:id' => 'public/password_recoveries#recover', as: 'recovery'

  match "/email/activity/:id" => "emails#activity"
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
  unless Rails.env.production?
    match "/enter/:id" => "sessions#enter", as: :enter
    match "/visitar/:id" => "library#enter", as: :visit_library
  end

  root to: "dashboards#site"
  WaxMuseum::Routes.draw
  scope ':library' do
    resources :shelves, path: '' do
      resource :activity
    end
  end
end

ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
