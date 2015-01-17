class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_default_format_json, :set_locale

protected

  def set_locale
    locales = I18n.available_locales
    I18n.locale = http_accept_language.compatible_language_from(locales)
  end

  def set_default_format_json
    request.format = Mime::JSON.to_sym if request.format == Mime::HTML
  end
end
