class ArtistsController < ApplicationController

def find
    render json: Artist.find(params["id"])
end
end