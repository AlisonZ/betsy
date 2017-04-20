class ProductsController < ApplicationController

    def index
        if params[:category_id]
            category = Category.find_by(id: params[:category_id])
            @products = category.products
        else
            @products = Product.all
            respond_to do |format|
                format.html
                format.csv { send_data @products.to_csv }
            end
        end
    end

    def show
        @product = Product.find(params[:id])
        @item = OrderItem.new
    end

    def new
        @product = Product.new
    end


    def create
        @product = Product.create(product_params)

        if @product.save
            flash[:success] = "#{@product.name} successfully added!"
            redirect_to products_path
        else
            flash[:failure] = "Something went wrong"
            render "new"
        end
    end

    def edit
        @product = Product.find_by_id(params[:id])
    end

    def update
        @product = Product.find_by_id(params[:id])

        if @product.update(product_params)
            flash[:success] = "#{@product.name} successfully edited"
            redirect_to product_path(@product.id)
        else
            flash.now[:error] = "Something went wrong..."
            render "edit"
        end
    end

    private

    def product_params
        params.require(:product).permit(:name, :user_id, :description, :stock, :price, :photo_url, :selling_status)
    end

end
