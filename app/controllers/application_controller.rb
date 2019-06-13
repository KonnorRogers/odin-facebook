# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: :true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attrs = %i[email first_name last_name password password_confirmation remember_me]
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: attrs)
  end
end
