class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

    def find
        render json: Album.find(params["id"])
    end

    def queue 
        render json: Album.albumqueue(params["id"])
    end
end