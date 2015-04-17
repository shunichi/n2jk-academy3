Rails.application.routes.draw do

  root 'home#index'

  resources :posts, only: %i(create update destroy), module: 'mine'

  resources :users, only: [] do
    resources :posts, only: %i(index show)
  end

  get '/auth/github/callback', to: 'sessions#create'
  get '/sign_in', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
