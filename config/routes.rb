Rails.application.routes.draw do

  root to: "sessions#index"

  resources :sessions, only: %i[new create destroy]

  resources :posts, param: :number


end
