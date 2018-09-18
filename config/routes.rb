Rails.application.routes.draw do
  get 'subscriptions/subscribe'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :posts

  # errors
  get '/not-found', to: 'errors#not_found'
  get '/not-found-again', to: 'application#not_found'

  # search
  get '/search', to: 'posts#search'

  # subscribers
  post '/subscribe', to: 'subscribers#subscribe'
  get '/subscribe/confirm/:token', to: 'subscribers#confirm'
end
