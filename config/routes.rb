Rails.application.routes.draw do
  devise_for :organizers
  get "/tournaments/my" => "tournaments#my", as: 'my_tournaments'
  get "/tournaments/:id" => "tournaments#show", as: 'tournament'
  namespace :api do
    namespace :v1 do
      resources :tournaments do
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#home"
end
