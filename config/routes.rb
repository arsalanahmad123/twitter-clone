Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  root "tweets#index"
  post 'user/follow',to: 'users#follow'
  get 'user/unfollow',to: 'users#unfollow'

  resources :tweets do
    member do
    put 'like', to: 'tweets#like'
    put 'unlike', to: 'tweets#unlike'
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
