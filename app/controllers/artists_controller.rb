class ArtistsController < ApplicationController

def find
    render json: Artist.find(params["id"])
end

def getall
    render json: Artist.getall(params["id"])
end
end