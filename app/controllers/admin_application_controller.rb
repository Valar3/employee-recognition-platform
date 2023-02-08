class AdminApplicationController < ActionController::Base
  before_action :authenticate_admin!
  layout 'admin_application.html.erb'
end
