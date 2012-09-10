Bookcamping::Application.routes.draw do
  root to: "dashboards#site"

  match '/entrar' => 'sessions#new', as: :login

  resources :libraries, only: [:show], path: ''
end
