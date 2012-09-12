Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'ver'
  end

  resources :users
  match '/entrar' => 'sessions#new', as: :login

  root to: "dashboards#site"
  resources :references
  resources :libraries, path: '', concerns: :library
end
