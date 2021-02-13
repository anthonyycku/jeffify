class PlaylistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        render json: Playlist.create(params["playlist"])
    end

    def index
        render json: Playlist.index(params["id"])
    end

    def specific
        render json: Playlist.specific(params["id"])
    end

    def addtoplaylist
        render json: Playlist.addtoplaylist(params["songID"], params["playlistID"])
    end

    def delete
        render json: Playlist.delete(params["id"])
    end

    def playlistsongs
        render json: Playlist.playlistsongs(params["id"])
    end

    def deletefromplaylist
        render json: Playlist.deletefromplaylist(params["id"])
    end
    
end 