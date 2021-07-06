Rails.application.routes.draw do
  root 'manga#index'
  get 'show_product/:id', to: 'manga#show', as: 'show_product'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
