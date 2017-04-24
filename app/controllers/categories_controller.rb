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
<<<<<<< HEAD
      category = Category.new
      category.name = params[:category][:name]
      if category.save
        redirect_to categories_path
      end
=======
        category = Category.new
        category.name = params[:category][:name]
        if category.save
            redirect_to :back
        end

>>>>>>> 35268c4127c73003fe347cf35e65b9f39270c81a
    end
end
