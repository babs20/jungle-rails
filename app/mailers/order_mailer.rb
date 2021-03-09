class OrderMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def welcome_email(order)
    @order = order
    @url = 'http://www.jungle.com'
    mail(to: order.email, subject: "Your jungle.com order ##{order.id}")
  end
end
