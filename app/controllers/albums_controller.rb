class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

    def find
        render json: Album.find(params["id"])
    end

    def queue 
        render json: Album.queue(params["id"])
    end

    def findAlbum
       render json: Album.findAlbum(params["id"]) 
    end
end