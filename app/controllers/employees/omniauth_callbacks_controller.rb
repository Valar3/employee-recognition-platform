module Employees
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :github

    def github
      @employee = Employee.from_omniauth(request.env['omniauth.auth'])

      if @employee.persisted?
        sign_in_and_redirect @employee, event: :authentication
        set_flash_message(:notice, :success, kind: 'Git hub') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_employee_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
