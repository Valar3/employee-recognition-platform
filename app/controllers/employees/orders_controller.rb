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
      reward = Reward.find(params[:reward_id])
      render :new, locals: { order_delivery: order_delivery, reward: reward, employee: current_employee }
    end

    def create
      order_delivery = OrderDelivery.new(order_delivery_params)
      reward = Reward.find(order_delivery.reward_id)
      order_delivery.employee = current_employee
              if order_delivery.employee.number_of_earned_points < reward.price
        redirect_to employees_rewards_path, alert: 'Not enough points'
      elsif order_delivery.save
            order_delivery.employee.decrement(:number_of_earned_points, reward.price).save
        redirect_to employees_rewards_path, notice: 'Order was successfully created.'
      else
        render :new, locals: { order_delivery: order_delivery, reward: reward, employee: current_employee }
      end
    end
    private

    def order
      @order ||= Order.find(params[:id])
    end
    def order_delivery_params
      params.require(:order_delivery).permit(:reward_id, :street, :city, :postcode, :address_id )
    end
  end
end
