Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'

  # Albums
  get '/allalbums', to:'albums#allAlbums'

end
