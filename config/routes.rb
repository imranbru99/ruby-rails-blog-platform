Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"
  get "about", to: "pages#about", as: :about
  get "category/:slug", to: "categories#show", as: :category

  namespace :admin do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    root "dashboard#index"
    resources :posts
    resources :categories
  end

  get "/:slug", to: "posts#show", as: :post, constraints: ->(req) {
    slug = req.path_parameters[:slug].to_s
    slug.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/) && Sluggable::RESERVED_SLUGS.exclude?(slug)
  }
end
