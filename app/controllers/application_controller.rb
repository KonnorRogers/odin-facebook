# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!, except: [:index]

  protected

  def after_sign_in_path_for(user)
    users_path
  end

  def configure_permitted_parameters
    sign_in_attrs = %i[email password password_confirmation]
    sign_up_attrs = %i[first_name last_name
                       remember_me birthday gender].concat(sign_in_attrs)
    # make it a singular array
    sign_up_attrs.flatten!

    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: sign_in_attrs)
    # devise_paramater_sanitizer.permit(:account_update, keys: sign_up_attrs)
  end
end
