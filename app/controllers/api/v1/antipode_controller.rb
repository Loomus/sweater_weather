class Api::V1::AntipodeController < ApplicationController
  def index
    # binding.pry
    # location = params[:location]
    render json: AnitpodeSerializer.new(
      AntipodeFacade.new(params[:location])
    )
  end
end
