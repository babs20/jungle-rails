class ReviewsController < ApplicationController
  before_filter :deny_access, unless: :is_logged_in?

  def create
    @review = Review.new(review_params)
    @review[:product_id] = params[:product_id]
    @review[:user_id] = current_user.id

    if @review.save
      redirect_to product_url params[:product_id]
    else
      @product = Product.find params[:product_id]
      render 'products/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_url params[:product_id], notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  protected

  def is_logged_in?
    current_user ? true : false
  end
end
