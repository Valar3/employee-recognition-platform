class AdminController < ApplicationController
  before_action :authenticate_admin!
  render layout: 'admin'
end

