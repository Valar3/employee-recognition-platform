module Employees
  class OrdersController < EmployeesController
    def index
      if params[:status] == "delivered"
        orders = Order.delivered
      elsif params[:status] == "non_delivered"
         orders = Order.non_delivered
      else
          orders = Order.all
      end
      render :index, locals: { orders: orders }
    end

    def create
      reward = Reward.find(params[:reward_id])
      order = reward.orders.new(employee: current_employee)
      Order.transaction do
        order.price = order.reward.price
        order.save!
        current_employee.number_of_earned_points -= reward.price
        Employee.transaction do
          current_employee.save!
          flash[:notice] = 'Reward was successfully bought'
          redirect_to employees_rewards_path
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:alert] = 'You do not have enough points'
      redirect_to employees_rewards_path
    end
  end
end
