Rails.application.routes.draw do
  get "/posts/get_posts"
  post "sessions/accept_cookies"
  get '/abouts/leaders', to: "leaders#index"

  resources :sessions, only: %i[accept_cookies]
  resources :posts, param: :number
  resources :documents, param: :page_title
  resources :abouts, param: :page_title
  scope "/abouts" do
    resources :leaders, param: :page_title
  end

  constraints subdomain: 'admin' do
    resources :sessions, only: %i[new create destroy]
    root "sessions#new", as: 'admin'
    get '/control_panel', to: "sessions#admin"
    get '/logout', to: "sessions#destroy"
    get '/abouts/leaders', to: "leaders#index"
    get 'sessions/get_admin_list'
    resources :sliders
    resources :headers
    resources :themes
    resources :posts, param: :number
    resources :documents, param: :page_title
    resources :abouts, param: :page_title
    scope "/abouts" do
      resources :leaders, param: :page_title
    end
  end

  root "sessions#index"

end
