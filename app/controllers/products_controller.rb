class ProductsController < ApplicationController

  def index
    if params[:category_id]
      category = Category.find_by(id: params[:category_id])
      @products = category.products
      @category_name = category.name.capitalize
    elsif params[:user_id]
      user = User.find_by(id: params[:user_id])
      @products = user.products
      @category_name = user.username.capitalize
    else
      @products = Product.all

    def show
        @product = Product.find_by_id(params[:id])
        if !@product
          render_404
        end
        @item = OrderItem.new
    end

      @category_name = "All Products"
    end
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
    end
    # raise
  end

  def show
    @product = Product.find(params[:id])
    @item = OrderItem.new
    # raise
  end

  def new
    @product = Product.new
    @category = Category.new
  end


  def create
    @product = Product.create(product_params)
    @product.user_id = current_user.id
    byebug
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
    params.require(:product).permit(:name, :description, :stock, :price, :photo_url, :selling_status, category_ids: [])
  end





end
