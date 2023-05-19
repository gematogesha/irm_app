Rails.application.routes.draw do

  root "sessions#index"
  get "/posts/get_posts"
  post "sessions/accept_cookies"

  resources :sessions, only: %i[new create destroy accept_cookies]
  resources :posts, param: :number
  resources :sliders
  resources :documents, param: :page_title



end
