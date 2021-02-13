class PlaylistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        render json: Playlist.create(params["playlist"])
    end

    def index
        render json: Playlist.index
    end

    def specific
        render json: Playlist.specific(params["id"])
    end

    def add
        render json: Playlist.add(params["playlist"])
    end
    
end 