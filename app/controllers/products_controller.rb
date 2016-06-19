class ProductsController < ApplicationController
  before_action :private_access, except:[:index, :show]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path, notice: "The product was successfully created"
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path, notice: "The product was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "The product was successfully deleted"
  end

  private
  def product_params
    params.require(:product).permit(:name, :url, :description, :image)
  end
end