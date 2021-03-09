class OrderMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def order_email(products, order)
    @order = order
    @products = products
    @url = 'http://www.jungle.com'
    mail(to: order.email, subject: "Your jungle.com order ##{order.id}")
  end
end
