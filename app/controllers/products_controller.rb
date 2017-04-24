class ProductsController < ApplicationController

  helper_method :can_review?, :can_edit?


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

      @category_name = "All Products"
    end
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
    end
  end

  def show
    @product = Product.find(params[:id])
    @item = OrderItem.new
    # raise
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
    params.require(:product).permit(:name, :user_id, :description, :stock, :price, :photo_url, :selling_status, category_ids: [])
  end

  def can_edit?
    # if there is a user logged in, see if the user's id matches the user_id in the product params
    if current_user
      # user = User.find_by_id(session[:user_id])
      # if someone is logged in
      product = Product.find_by_id(params[:id])
      if current_user.id == product.user_id
        # if logged-in user is owner of product
        return true
      else
        # if it is not user's product, no edit button
        return false
      end
    else
      # if no one is logged in you can't edit
      return false
    end
  end

  def can_review?
    if current_user
      # user = User.find_by_id(session[:user_id])
      product = Product.find_by_id(params[:id])

      if current_user.id == product.user_id
        # if someone is logged in and they are the owner of the product -- they can't review it
        return false
      else
        return true
      end
    else
      return true
    end

  end

end
