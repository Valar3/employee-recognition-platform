  class OrderService
    def initialize(order, reward, current_employee, order_params)
      @order = order
      @reward = reward
      @current_employee = current_employee
      @order_params = order_params
    end
    binding.pry
    def process_order
      case @reward.delivery_method
      when 'post_delivery'
        process_post_delivery
      when 'online_delivery'
        process_online_delivery
      end
    end
    binding.pry

    private

    def process_post_delivery
      if @reward.available_rewards.positive?
        @current_employee.pin_address
        @order.place_order(@current_employee)
        return :success
      else
        return :reward_not_available
      end
    end
    binding.pry

    def process_online_delivery
      if @reward.available_rewards.positive?
        @order.place_order(@current_employee)
        online_code = @reward.online_codes.where(used: false).first
        online_code&.update(used: true)
        return :success
      else
        return :reward_not_available
      end
    end
  end
