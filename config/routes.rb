Rails.application.routes.draw do
  resources :games, only: [:index, :show, :new, :create] do
    resources :guesses, only: :create
  end

  root "games#index"
end
