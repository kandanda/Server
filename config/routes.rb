Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :organizers
  get "/tournaments/my" => "tournaments#my", as: 'my_tournaments'
  get "/tournaments/:id" => "tournaments#show", as: 'tournament'
  get "/tournaments/:id/embed" => "tournaments#embed", as: 'embed_tournament'
  post "/tournaments/:id/subscribe" => "tournaments#subscribe", as: 'subscribe_tournament'
  get "/tournaments/unsubscribe/:token" => "tournaments#unsubscribe", as: 'unsubscribe_tournament'
  namespace :api do
    namespace :v1 do
      resources :tournaments do
      end
      post 'auth' => "auth#create"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#home"
end
