class SongsController < ApplicationController

    def index
        render json: Song.all
    end

    def specific
        render json: Song.specific(params["id"])
    end
end