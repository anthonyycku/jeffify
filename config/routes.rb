Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'
  get '/specific/:id', to: 'songs#specific'

  # Albums
  get '/albums', to:'albums#index'
  get '/find/:id', to:'albums#find'

  #Resources
  resources :audios, only: :show
end
