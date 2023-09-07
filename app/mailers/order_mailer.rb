class OrderMailer < ApplicationMailer
  def confirmation_email
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order has been delivered')
  end

  def mail_with_code
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your online code is here')
  end

  def mail_with_directions
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your pick-up delivery directions')
  end
end
