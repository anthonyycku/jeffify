class AlbumsController < ApplicationController

    def allAlbums
        render json: Album.allAlbums
    end

end