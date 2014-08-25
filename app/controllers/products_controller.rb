class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]
  def require_authentication
    unless current_user
      redirect_to new_user_session_path, alert: 'Precisa esta logado!'
    end
  end
  def require_no_authentication
    if current_user
      redirect_to root_path,
      notice: t('flash.notice.already_logged_in')
    end
  end

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
  @search_query = params[:q]

  order = params[:order]

  if order
    order = eval(order)
  end

  if order == 1
    @products = Product.search(@search_query).order("id desc").page(params[:page]).per(5)
  elsif order == 2
    @products = Product.search(@search_query).order("price").page(params[:page]).per(5)
  elsif order == 3
    @products = Product.search(@search_query).order("price desc").page(params[:page]).per(5)
  else
    @products = Product.search(@search_query).order("title").page(params[:page]).per(5)
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

  if @product.save
    redirect_to @product, notice: 'Produto cadastrado com sucesso.'
  else
    render :new 
  end
end


def update
  @product = current_user.products.find(params[:id])
  if @product.update(product_params)
    redirect_to @product, notice: 'Produto atualizado.' 
  else
    render :show
  end
end


def destroy
  if @product.destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    redirect_to products_url
  else
    redirect_to :back, notice: "Seu TROUXA"
  end
end

private 
 # ensure that there are no line items referencing this product 
 def ensure_not_referenced_by_any_line_item 
   if line_items.empty? 
     return true 
   else 
     errors.add(:base, 'Line Items present') 
     return false 
   end 
 end

 def set_product
  @product = Product.find(params[:id])
end


def product_params
  params.
  require(:product).permit(:title, :price, :description, :style_id, :category_id, :user_id, :cover, :file)
end
end
