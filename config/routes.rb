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
  #Signup login
  get 'login', to: 'user#login', as: 'login'
  post 'login', to: 'user#session'
  get 'signup', to: 'user#signup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
