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
  end
end
