class AccountsController < ApplicationController

    def index
        render json: Account.index
    end

    def create
        render json: Account.create(params["account"])
    end
end