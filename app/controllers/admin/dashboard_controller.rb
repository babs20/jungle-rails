class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_ADMIN_AUTH_USERNAME'],
                               password: ENV['BASIC_ADMIN_AUTH_PASSWORD']

  def show
    @product_amount = Product.all.count
    @category_amount = Category.all.count
  end
end
