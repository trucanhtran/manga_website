Rails.application.routes.draw do
  root 'manga#index'
  get 'show_product/:id', to: 'manga#show', as: 'show_product'
  #Search
  post 'search', to: 'manga#search', as: 'search'
  get 'products', to: 'manga#show_result', as: 'show_result'

  get 'chapter/:id', to: 'chapter#show', as: 'show_chapter'
  post 'change_chapter', to: 'chapter#change_chapter', as:'change_chapter'
  # Categoies
  get 'categories', to: 'category#show', as: 'show_categories'
  get 'category/:id', to: 'category#show_category', as: 'show_category'
  get 'hot_products', to: 'category#show_hot_products', as: 'hot_products'
  get 'new_products', to: 'category#show_new_products', as: 'new_products'
  #Login
  get 'login', to: 'manga#login', as: 'login'
  get 'signup', to: 'manga#signup', as: 'signup'
  post 'signup', to: 'manga#create_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
