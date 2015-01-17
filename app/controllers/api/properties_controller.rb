module API
  class PropertiesController < ApplicationController
    def index
      properties = Property.all
      if province = params[:province]
        properties = properties.where(province: province)
      end
      render json: properties, status: 200
    end

    def show
      property = Property.find(params[:id])
      render json: property, status: 200
    end
  end
end
