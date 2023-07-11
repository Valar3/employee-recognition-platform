# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def pundit_user
    current_employee
  end
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name surname email password current_password])
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end
end
