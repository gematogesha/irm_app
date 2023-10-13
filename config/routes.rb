Rails.application.routes.draw do
  get "/posts/get_posts"
  post "sessions/accept_cookies"
  get '/abouts/leaders', to: "leaders#index"
  get "/privacy", to: "sessions#privacy"
  get "/admin", to: "sessions#new"
  get '/control_panel', to: "sessions#admin"
  get '/logout', to: "sessions#destroy"
  get '/abouts/leaders', to: "leaders#index"
  get 'sessions/get_admin_list'

  resources :sessions, only: %i[accept_cookies new create destroy]
  resources :banners
  resources :headers
  resources :themes
  resources :activities, param: :page_title
  resources :sciences, param: :page_title
  resources :products, param: :page_title
  resources :careers, param: :page_title
  resources :others, param: :page_title
  resources :posts, param: :number
  resources :documents, param: :page_title
  resources :abouts, param: :page_title

  scope "/abouts" do
    resources :leaders, param: :page_title
  end

  root "sessions#index"

end