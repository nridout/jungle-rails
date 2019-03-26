class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user

    if @review.save
      flash[:success] = "Thank you for submitting your review!"
      redirect_to product_path(params[:product_id])
    else
      flash.now[:danger] = 'Error submitting review'
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy!
    redirect_to product_path(params[:product_id])
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end

  def delete_review
    review.delete(:review)
  end
end