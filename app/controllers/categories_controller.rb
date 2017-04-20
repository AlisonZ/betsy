class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        category = Category.new
        category.name = params[:category][:name]
        if category.save
            redirect_to category_path
        end

    end
end
