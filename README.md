# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of learning Rails by example.

After self-learning Ruby for a few days prior, students jump head first into a partially completed app. The student is tasked with bug fixes and feature requests, which they must complete using only their prior programming knowledge from JavaScript and the Rails documentation.

## Screenshots

Product Page
!["Add New Appointments!"](https://github.com/babs20/jungle-rails/blob/master/docs/product_page.png)

Cart
!["Delete or Edit Exisiting Appointments!"](https://github.com/babs20/jungle-rails/blob/master/docs/cart.png)

Reviews
!["Delete or Edit Exisiting Appointments!"](https://github.com/babs20/jungle-rails/blob/master/docs/reviews.png)

Admin Product Panel
!["Delete or Edit Exisiting Appointments!"](https://github.com/babs20/jungle-rails/blob/master/docs/admin_products.png)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account (if needed)
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4242 4242 4242 4242 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
- PostgreSQL 9.x
- Stripe
