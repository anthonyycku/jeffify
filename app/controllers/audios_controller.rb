class AudiosController < ApplicationController

    def show
        @audio = Audio.find(params["id"])
        render :show
    end

end