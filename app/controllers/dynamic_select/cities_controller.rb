module DynamicSelect
  class CitiesController < ApplicationController
    respond_to :json

    def index
      @cities = City.where(:state_id => params[:state_id])
      respond_with(@cities)
    end
  end
end