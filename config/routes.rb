Rails.application.routes.draw do

  root "sessions#index"
  get "/posts/get_posts"
  post "sessions/accept_cookies"

  resources :sessions, only: %i[accept_cookies]
  resources :posts, only: %i[index show], param: :number
  resources :documents, only: %i[index show], param: :page_title
  resources :abouts, only: %i[index show], param: :page_title

  constraints subdomain: 'admin' do
    resources :sessions, only: %i[new create destroy]
    get '/login', to: "sessions#new"
    get '/control-panel', to: "sessions#admin"
    get '/logout', to: "sessions#destroy"
    resources :sliders
    resources :posts, param: :number
    resources :documents, param: :page_title
    resources :abouts, param: :page_title
  end

end
