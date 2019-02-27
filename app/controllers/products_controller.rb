class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    @products = Product.all.order('created_at DESC').page(params[:page])
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = current_user.products.build(product_params)
    3.times {@product.subimages.build}
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to controller: 'products', action: 'index'
    else
      @products = current_user.products.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'product/index'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def product_params
    params.fetch(:product, {}).permit(:image, :title, :content, subimages_attributes: [:sub_image, :_destroy])
  end
  
  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    unless @product
      redirect_to root_url
    end
  end
  
end
