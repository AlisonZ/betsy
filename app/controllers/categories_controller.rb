class CategoriesController < ApplicationController
    def index
        @categories = Category.all

        respond_to do |format|
          format.html
          format.csv { send_data @categories.to_csv }
        end
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
