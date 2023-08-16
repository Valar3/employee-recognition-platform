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
      order = Order.new
      reward = Reward.find(params[:reward_id])
      render :new, locals: { order:, reward:, employee: current_employee }
    end

    def create
      reward = Reward.find(params[:order][:reward_id])
      order = current_employee.orders.build(reward:)
      order.price = reward.price

      service = OrderService.new(order, reward, current_employee, params[:order])

      case service.process_order
      when :success
        flash[:notice] = 'Order successfully processed'
        redirect_to employees_rewards_path
      when :reward_not_available
        flash[:alert] = 'Order processing failed: Reward not available'
        redirect_to employees_rewards_path
      when :invalid_delivery_method
        flash[:alert] = 'Invalid delivery method'
        redirect_to employees_rewards_path
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.message
      redirect_to employees_rewards_path
    end

    private

    def order_params
      params.require(:order).permit(:reward_id, :city, :postcode, :street)
    end
  end
end
