Rails.application.routes.draw do
  root "application#home"
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :rooms
  resources :tenants, only: %i[index new create destroy]
  get "/billing", to: "billing#index", as: :billing
  get "/billing/history", to: "billing#history", as: :billing_history
  patch "/billing/rooms/:id", to: "billing#update", as: :billing_room
  patch "/billing/invoices/:id/pay", to: "billing#pay", as: :pay_invoice

  get "up" => "rails/health#show", as: :rails_health_check
end
