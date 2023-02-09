Rails.application.routes.draw do

  root to: "sessions#index"

  resources :sessions

end
