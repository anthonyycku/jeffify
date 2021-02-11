class UsersController < ApplicationController

    def index
        render json: User.index
    end

    def create
        render json: User.create(params["username"], params["password"])
    end
end