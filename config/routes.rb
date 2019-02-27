Rails.application.routes.draw do
  get 'products/index'

  get 'products/show'

  get 'products/new'

  get 'products/create'

  get 'products/destroy'

  devise_for :users
  get 'home/index'

  get 'allworks/show'

  root to: 'toppages#index'
  
  get 'allworks', to: 'allworks#show'
  
  resources :products, only: [:index, :show, :new, :create, :destroy]
  
end