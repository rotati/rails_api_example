module V1
  class PropertiesController < ApplicationController
    def ping
      render json: { pong: "From V1 PropertiesController: #{DateTime.now}" }
    end

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
        render json: property, status: :created, location: v1_property_url(property)
      else
        render json: property.errors, status: :unprocessable_entity
      end
    end

    def update
      property = Property.find(params[:id])

      if property.update(property_params)
        render json: property, status: :success
      else
        render json: property.errors, status: :unprocessable_entity
      end
    end

    def destroy
      property = Property.find(params[:id])
      property.destroy
      head 204
    end

private
    def property_params
      params.require(:property).permit(:name, :width, :length, :province)
    end
  end
end
