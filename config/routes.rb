Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  mount ActionCable.server => '/cable'
  resources :questions do
    resources :answers
  end
end
