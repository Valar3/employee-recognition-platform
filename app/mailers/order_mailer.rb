class OrderMailer < ApplicationMailer
  default from: 'admin@big_company.com'

  def confirmation_email
    @order = params[:order]
    mail(to: @order.employee.email, subject: 'Your order has been delivered')
  end
end