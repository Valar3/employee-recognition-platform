module Admins
  module Employees
    class MassEditController < AdminController
      def edit
        @employee = Employee.all
      end

      def update
        Employee.find_each do |employee|
          Employee.transaction do
           employee.update!(employee_params)
            flash[:notice] = 'Successfully updated the numer of kudos to all employees'
            redirect_to admins_employee_mass_edit_path
          rescue ActiveRecord::RecordInvalid
            flash[:notice] = 'The numer of kudos you want to add is too high'
           end
