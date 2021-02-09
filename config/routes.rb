Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#specific'

  # Albums
  get '/albums', to:'albums#index'
  get '/albums/:id', to:'albums#find'
  get '/queue/:id', to: 'albums#queue'
  get '/findalbum/:id', to:'albums#findAlbum'

  #Artist
  get '/artistsongs/:id', to:'artists#allsongs'
  get '/artists/:id', to:'artists#find'
end
