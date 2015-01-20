class V2::PropertiesController < ApplicationController
  def index
    render json: []
  end

  def ping
    render json: { pong: "From V2 PropertiesController: #{DateTime.now}" }
  end
end
