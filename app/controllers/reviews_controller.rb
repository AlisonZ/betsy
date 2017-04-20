class ReviewsController < ApplicationController
    def new
        @review = Review.new
    end

    def create
        review = Review.new
        review.title = params[:review][:title]
        review.rating = params[:review][:rating]
        if review.save
            redirect_to product_path(params[:id])
        end
    end
end
