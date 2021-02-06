class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

    def find
        render json: Album.find(params["id"])
    end
end