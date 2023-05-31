Rails.application.routes.draw do

  root "sessions#index"
  get "/posts/get_posts"
  post "sessions/accept_cookies"

  resources :sessions, only: %i[new create accept_cookies]
  resources :posts, param: :number
  resources :documents, param: :page_title
  resources :abouts, param: :page_title
  get '/login', to: 'sessions#new'

  constraints subdomain: 'admin' do
    get '/control-panel', to: "sessions#admin"
    resources :sliders
    resources :sessions, only: %i[destroy]
  end

end
