Bookcamping::Application.routes.draw do
  concern :library do
    resources :shelves, path: 'en' do
      resources :references, only: 'show', path: 'ver', controller: :shelf_references
    end
  end

  resources :users
  match '/entrar' => 'sessions#new', as: :login

  root to: "dashboards#site"
  resources :references
  resources :libraries, path: 'en', concerns: :library
end
