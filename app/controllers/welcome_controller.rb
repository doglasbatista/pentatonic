class WelcomeController < ApplicationController
  include CurrentCart

  def index
    @products = Product.search(@search_query).order("id desc").page(params[:page]).per(20)
  end

  def myProducts   
    @products = current_user.products
  end

  def products
    user = User.find(params[:id])
    @products = user.products
  end

  def aboutUs
  end
  
  def save
   @order = Order.new
   @order.user_id = current_user.id
   @order.total_price = current_cart.total_price
   @order.add_line_order_from_cart(current_cart)
   if @order.save
     current_cart.line_items.each do |i| 
      i.destroy
     end
     flash[:notice] = "Obrigado por sua compra."     
   else
    render :action => "checkout"
  end
end

def checkout
  unless current_user
    flash[:notice] = "Para finalizar sua compra você 
    precisa estar logado no sistema."
    redirect_to new_user_session_path
  else
    if current_cart.line_items.count == 0
      flash[:notice] = "Seu carrinho de compras está vazio"
      redirect_to :back
    else
      @order = Order.new
    end
  end
end


end
