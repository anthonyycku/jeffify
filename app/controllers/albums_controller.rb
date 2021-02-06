class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

    def allAlbums
        render json. Album.allAlbums()
    end

end