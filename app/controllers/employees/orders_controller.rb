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
      reward_id = params[:order][:reward_id]
      puts "Debug: Reward ID from params: #{reward_id}" # Debug statement
      reward = Reward.find(reward_id)
      puts "Debug: Reward found: #{reward.inspect}"
    order = current_employee.orders.build(reward: reward)
    order.price = reward.price

    case reward.delivery_method
    when 'post_delivery'
      if reward.available_rewards.positive?
      current_employee.city = params[:order][:city]
      current_employee.postcode = params[:order][:postcode]
      current_employee.street = params[:order][:street]
      current_employee.save
      order.place_order(current_employee)
      end

    when 'online_delivery'
      
      if reward.available_rewards.positive?
        order.place_order(current_employee)
         order.save
          online_code = reward.online_codes.where(used: false).first
          online_code.update(used: true) if online_cod
      end
    end

    flash[:notice] = 'Reward was successfully bought'
    redirect_to employees_rewards_path
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
