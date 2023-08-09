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
      order = current_employee.orders.build(order_params)
      reward = Reward.find(order.reward_id)
      order.price = order.reward.price
    case reward.delivery_method
      when reward.post_delivery?
        current_employee.city = order.city
        current_employee.postcode = order.postcode
        current_employee.street = order.street
        current_employee.save
      when reward.online_delivery?
        order.status = :delivered
        if reward.available_online_codes.positive?
          order = Order.new(reward: reward, employee: current_employee)

          if order.save
            online_code = reward.online_codes.where(used: false).first
            online_code.update(used: true) if online_code
            redirect_to order, notice: 'Order successfully placed.'
          end
        end
      end

      Order.transaction do
        order.reward.available_rewards.decrement(:available_rewards)
        order.save!
        current_employee.number_of_earned_points -= reward.price
        current_employee.save!
      end

      flash[:notice] = 'Reward was successfully bought'
      redirect_to employees_rewards_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.message
      redirect_to employees_rewards_path
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:reward_id, :city, :postcode, :street)
    end
  end
end
