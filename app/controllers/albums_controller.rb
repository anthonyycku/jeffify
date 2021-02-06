class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

    def findAlbum
        render json: Album.findAlbum(params["id"])
    end
end