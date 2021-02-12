class PlaylistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        render json: Playlist.create(params["playlist"])
    end

    def index
        render json: Playlist.index
    end

end