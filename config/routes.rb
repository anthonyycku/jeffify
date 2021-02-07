Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#specific'

  # Albums
  get '/albums', to:'albums#index'
  get '/albums/:id', to:'albums#find'
  get '/queue/:id', to: 'albums#queue'

end
