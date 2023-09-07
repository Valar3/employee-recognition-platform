class OrderService
  def initialize(order, reward, current_employee, order_params)
    @order = order
    @reward = reward
    @current_employee = current_employee
    @order_params = order_params
  end

  def process_order
    case @reward.delivery_method
    when 'post_delivery'
      process_post_delivery
    when 'online'
      process_online_delivery
    when 'pick_up_delivery'
      process_pick_up_delivery
    else
      :invalid_delivery_method
    end
  end

  private

  def process_post_delivery
    update_employee_address
    place_order
    :success
  end

  def process_online_delivery
    @order.status = 'delivered'
    place_order
    OrderMailer.with(order: @order, reward: @reward).mail_with_code.deliver_later
    update_online_code
    :success
  end

  def process_pick_up_delivery
    place_order
    OrderMailer.with(order: @order, reward: @reward).mail_with_directions.deliver_later
    :success
  end

  def update_employee_address
    @current_employee.city = @order_params[:city]
    @current_employee.postcode = @order_params[:postcode]
    @current_employee.street = @order_params[:street]
    @current_employee.save
  end

  def place_order
    Order.transaction do
      @reward.decrement(:available_rewards, 1)
      @reward.save!
      @current_employee.decrement(:number_of_earned_points, @reward.price)
      @current_employee.save!
      @order.save!
    end
  end

  def update_online_code
    online_code = @reward.online_codes.where(used: false).first
    online_code&.update(used: true)
  end
end
