class OrderMailer < ApplicationMailer
  default from: 'valar@employeerp.co.uk'

  def confirmation_email
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order has been delivered')
  end
end
