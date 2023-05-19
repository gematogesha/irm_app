Rails.application.routes.draw do

  root "sessions#index"
  get "/posts/get_posts"

  resources :sessions, only: %i[new create destroy]
  resources :posts, param: :number
  resources :sliders
  resources :documents, param: :page_title



end
