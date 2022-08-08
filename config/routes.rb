Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    member do
      get 'followings'
      get 'followers'
    end
  end

  post 'following_relationship/:target_id', to: 'follow_relationships#create', as: :follow
  delete 'following_relationship/:target_id', to: 'follow_relationships#destroy', as: :un_follow
end
