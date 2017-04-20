class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end

    def create
        @review = Review.new
        @review.title = params[:review][:title]
        @review.rating = params[:review][:rating]
        @review.product_id = params[:product_id]
        if @review.save

            redirect_to products_path
        else
            render 'new'
        end
    end
end
