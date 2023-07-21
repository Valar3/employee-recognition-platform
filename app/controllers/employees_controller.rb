class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  
end
