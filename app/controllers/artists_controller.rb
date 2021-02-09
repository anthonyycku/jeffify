class ArtistsController < ApplicationController

    def find
     render json: Artist.find(params["id"])
    end

    def allsongs
        render json: Artist.allsongs(params["id"])
    end
end