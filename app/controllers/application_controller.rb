# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def pundit_user
    current_employee
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end
end
