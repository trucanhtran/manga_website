Rails.application.routes.draw do
  root 'manga#index'
  get 'show_product/:id', to: 'manga#show', as: 'show_product'
  get 'chapter/:id', to: 'chapter#show', as: 'show_chapter'
  post 'change_chapter', to: 'chapter#change_chapter', as:'change_chapter'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
