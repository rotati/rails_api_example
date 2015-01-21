class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:exclusive]

  def index
    @properties = Property.all

    if province = params[:province]
      @properties = @properties.where(province: province)
    end

    render json: @properties
  end

  def show
    render json: @property
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      render json: @property, status: :created, location: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: @property, status: :success
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    head 204
  end

  def exclusive
    render json: { message: "Welcome exclusive member!" }
  end

protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      return (username == 'dadou' && password == 'dadouland')
    end
  end

private
  def property_params
    params.require(:property).permit(:name, :width, :length, :province)
  end

  def set_property
    @property ||= Property.find(params[:id])
  end

  # This method can also be moved into the ApplicationController ...
  def set_version
    if @properties
      @properties.each{|p| p.extend(version_module)}
    else
      @property.extend(version_module)
    end
  end
end
