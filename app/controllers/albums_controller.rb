class AlbumsController < ApplicationController

    def index
        render json: Album.all
    end

end