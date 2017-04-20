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

    end
end
