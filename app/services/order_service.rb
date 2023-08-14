  class OrderService
    def initialize(order, reward, current_employee, order_params)
      @order = order
      @reward = reward
      @current_employee = current_employee
      @order_params = order_params
    end

    def process_order
      case @reward.delivery_method
      when 'online_delivery'
        process_online_delivery
      when 'post_delivery'
        process_post_delivery

      end
    end

    private


    def process_post_delivery
      if @reward.available_rewards.positive?
        @current_employee.city = @order_params[:city]
        @current_employee.postcode = @order_params[:postcode]
        @current_employee.street = @order_params[:street]
        @current_employee.save
        @order.place_order(@current_employee)
        return :success
      else
        return :reward_not_available
      end
    end

    def process_online_delivery
      if @reward.available_rewards.positive?
        @order.place_order(@current_employee)
        @order.save
        online_code = @reward.online_codes.where(used: false).first
        online_code&.update(used: true)
        return :success
      else
        return :reward_not_available
      end
    end
  end
