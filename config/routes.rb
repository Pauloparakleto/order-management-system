Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'orders#index'
  resources :orders, only: [:index, :create, :show, :new, :edit, :update]
end
