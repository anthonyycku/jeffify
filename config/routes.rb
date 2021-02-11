Rails.application.routes.draw do

  # Songs
  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#specific'
  get '/songsearch', to: 'songs#songsearch'

  # Albums
  get '/albums', to:'albums#index'
  get '/albums/:id', to:'albums#find'
  get '/queue/:id', to: 'albums#queue'
  get '/findalbum/:id', to:'albums#findAlbum'

  #Artist
  get '/artistsongs/:id', to:'artists#allsongs'
  get '/artists/:id', to:'artists#find'
  get '/artistsearch', to:'artists#artistsearch'

  #Users
  get '/accounts', to:'accounts#index'
  post '/accounts', to:'accounts#create'

end
