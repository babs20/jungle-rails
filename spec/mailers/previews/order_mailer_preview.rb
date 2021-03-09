# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

class OrderMailerPreview < ActionMailer::Preview
  def welcome_email
    @order =
      Order.new(
        id: 1,
        email: 'test@gmail.com',
        total_cents: 98_765,
        stripe_charge_id: 'ch_1IT9RiCp344NE9UqfVb8VZ4j',
      )

    @product =
      Product.new(
        name: 'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99,
      )

    @products = [
      {
        product: @product,
        quantity: 1, # Number
        total: 98_765, # Number
      },
    ]

    p @order
    p @products
    OrderMailer.order_email(@products, @order)
  end
end
