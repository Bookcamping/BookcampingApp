Bookcamping::Application.routes.draw do
  root to: "dashboards#site"

  match '/entrar' => 'sessions#new', as: :login
end
