class PlaylistsController < ApplicationController

    def create
        render json: Playlist.create(params["playlist"])
    end

    def index
        render json: Playlist.index
    end

end