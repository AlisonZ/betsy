class ProductsController < ApplicationController

def index
  @products = Product.all
end

def show
  @product = Product.find(params[:id])
end

def new
  @product = Product.new
end


def create
  @product = Product.new
  @product.name = params[:product][:name]
  @product.description = params[:product][:description]
  @product.stock = params[:product][:stock]
  @product.price = params[:product][:price]
  @product.user_id = params[:product][:user_id]

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

  @product.name = product_params[:name]
  @product.price = product_params[:price]
  @product.stock = product_params[:stock]
  @product.description = product_params[:description]

  if @product.save
    flash[:success] = "#{@product.name} successfully edited"
    redirect_to product_path(@product.id)
  else
      flash.now[:error] = "Something went wrong..."
      render "edit"
  end
end

private

def product_params
  params.require(:product).permit(:name, :user_id, :description, :stock, :price)
end

end
