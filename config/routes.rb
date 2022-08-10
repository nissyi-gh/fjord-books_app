Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    member do
      get 'followings'
      get 'followers'
      post 'follow_relationships', to: 'users#follow'
      delete 'follow_relationship', to: 'users#un_follow'
    end
  end
end
