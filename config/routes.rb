Rails.application.routes.draw do

  root 'home#index'

  get '/auth/github/callback', to: 'sessions#create'
  get '/sign_in', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
