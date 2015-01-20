class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_default_format_json, :set_locale

protected

  def set_locale
    locales = I18n.available_locales
    I18n.locale = http_accept_language.compatible_language_from(locales)
  end

  def set_default_format_json
    request.format = Mime::JSON.to_sym if request.format == Mime::HTML
  end

  def render(*args)
    # Only set the version if the requested version is not the default models version
    set_version if requested_version != model_constant::VERSION
    super
  end

  def requested_version
    @requested_version ||= params[:version].blank? ? request.headers['ACCEPT'].gsub('application/vnd.rotati.','')[1..8] : params[:version]
  end

  def version_module
    @version_module ||= "#{model_name}RepresentationV#{requested_version}".constantize
  end

  def model_name
    params[:controller].singularize.capitalize
  end

  def model_constant
    model_name.constantize
  end
end
