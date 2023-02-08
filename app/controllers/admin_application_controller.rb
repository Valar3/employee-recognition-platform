class AdminApplicationController < ActionController::Base
  before_action :authenticate_admin!
  render 'layouts/admin.html.erb'
end
