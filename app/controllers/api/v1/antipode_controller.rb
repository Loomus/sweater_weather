class Api::V1::AntipodeController < ApplicationController
  def index
    render json: AntipodeSerializer.new(AntipodeFacade.new(params[:location]).expose_antipode_forecast)
  end
end
