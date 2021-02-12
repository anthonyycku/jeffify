class PlaylistsController < ApplicationController

    def create
        render json: Playlist.create(params["playlist"])
    end

end