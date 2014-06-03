class OrderMailer < ActionMailer::Base
  default from: "no-reply@myinstagram.com"

  def successful_order(order)
    @order = order
    
    mail(to: @order.user.email, subject: 'Thanks for your order')
  end
end
