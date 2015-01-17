module API
  class PropertiesController < ApplicationController
    def index
      @properties = Property.all

      if province = params[:province]
        @properties = @properties.where(province: province)
      end

      respond_to do |format|
        format.json
        format.xml { render xml: @properties, status: 200 }
      end
    end

    def show
      @property = Property.find(params[:id])

      respond_to do |format|
        format.json
        format.xml { render xml: @property, status: 200 }
      end
    end

    def create
      property = Property.new(property_params)

      if property.save
        render json: property, status: :created, location: api_property_url(property)
      else
        render json: property.errors, status: :unprocessable_entity
      end
    end

private
    def property_params
      params.require(:property).permit(:name, :width, :length, :province)
    end
  end
end
