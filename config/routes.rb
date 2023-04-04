Rails.application.routes.draw do

  root to: "sessions#index"

  resources :sessions, only: %i[new create destroy]

  resources :news, param: :number



end
