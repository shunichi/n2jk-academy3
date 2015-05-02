Rails.application.routes.draw do

  root 'home#index'

  scope module: 'mine' do
    resources :posts, only: %i(new create update destroy) do
      resources :comments, only: %i(create update destroy)
    end
  end
  namespace :mine do
    resource :user, only: %i(update)
  end

  resources :users, only: %i(show) do
    resources :posts, only: %i(show) do
      member do
        patch 'read'
      end
    end
  end

  get '/auth/github/callback', to: 'sessions#create'
  get '/sign_in', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
