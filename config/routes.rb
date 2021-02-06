Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'

  # Albums
  get '/albums', to:'albums#index'

end
