class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def file_download
    @product = Product.find(params[:id])
    file_path = @product.file_file_name
    if !file_path.nil?
     send_file "#{Rails.root}/public/system/file/#{@product.id}/original/#{file_path}", :x_sendfile => true 
    else 
     redirect_to products_url
    end
  end
  
def index

  order = params[:order]

  if order
    order = eval(order)
  end

  if order == 1
    @products = Product.order("id desc").page(params[:page]).per(5)
  elsif order == 2
    @products = Product.order("price").page(params[:page]).per(5)
  elsif order == 3
    @products = Product.order("price desc").page(params[:page]).per(5)
  else
    @products = Product.order("title").page(params[:page]).per(5)
  end

end


def show
  @product = Product.find(params[:id])
end


def new
  @product = current_user.products.build
end


def edit
end


def create
  @product = current_user.products.build(product_params)

  respond_to do |format|
    if @product.save
      format.html { redirect_to @product, notice: 'Product was successfully created.' }
      format.json { render :show, status: :created, location: @product }
    else
      format.html { render :new }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
end


def update
  @product = current_user.products.find(params[:id])

  respond_to do |format|
    if @product.update(product_params)
      format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      format.json { render :show, status: :ok, location: @product }
    else
      format.html { render :edit }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
end


def destroy
  @product.destroy
  respond_to do |format|
    format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private

def set_product
  @product = Product.find(params[:id])
end


def product_params
  params.require(:product).permit(:title, :price, :description, :style_id, :category_id, :user_id, :cover, :file)
end
end
