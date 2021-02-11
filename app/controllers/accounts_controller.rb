class AccountsController < ApplicationController

    def index
        render json: Account.index
    end

    def create
        render json: Account.create(params["username"], params["password"])
    end
end