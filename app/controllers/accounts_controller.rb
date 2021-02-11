class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        render json: Account.index
    end

    def create
        render json: Account.create(params["account"])
    end
end