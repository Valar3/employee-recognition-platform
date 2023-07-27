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
      render :new, locals: { order: order, reward: reward, employee: current_employee }
    end

    def create
    order = Order.new(order_params)
    order.employee_id = current_employee.id
    order.price = order.reward.price
    if order.reward.post_delivery?
      order.street = params[:order_street]
      order.city = params[:order][:city]
      order.postcode = params[:order][:postcode]
    end

    Order.transaction do


      if order.save
        current_employee.update!(number_of_earned_points: current_employee.number_of_earned_points - order.reward.price)
      end

      flash[:notice] = 'Order was successfully created'
      redirect_to employees_rewards_path
    end

  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Failed to create order'
    render :new, locals: { order: order, reward: Reward.find(params[:order][:reward_id]), employee: current_employee }
  end
    private

    def order
      @order ||= Order.find(params[:id])
    end
    def order_params
      params.require(:order).permit(:reward_id, :street, :city, :postcode )
    end
  end
end
