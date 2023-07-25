module Employees
  class OrdersController < EmployeesController
    def index
      orders = case params[:status]
               when 'delivered'
                 Order.delivered
               when 'non_delivered'
                 Order.non_delivered
               else
                 Order.all
               end
      render :index, locals: { orders: }
    end
    def new
      order_delivery = OrderDelivery.new
      reward = Reward.find(params[:format])
      render :new, locals: { order_delivery: order_delivery, reward: reward, employee: current_employee }
    end

    def create
      order_delivery = OrderDelivery.new(order_delivery_params)
      reward = Reward.find(order_delivery.reward_id)
      order_delivery.employee = current_employee
      Order.transaction do
        order_delivery.price = order_delivery.reward.price
        order_delivery.save!
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
    private

    def order
      @order ||= Order.find(params[:id])
    end
    def order_delivery_params
      params.require(:order_delivery).permit(:reward_id, :address_id, :city, :postcode, :street)
    end
  end
end
