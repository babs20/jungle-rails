class Admin::DashboardController < ApplicationController
  def show
    @product_amount = Product.all.count
    @category_amount = Category.all.count
  end
end
