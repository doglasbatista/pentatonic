class WelcomeController < ApplicationController
  include CurrentCart

  def index
    @products = Product.order("id desc").page(params[:page]).per(12)
  end

  def myProducts   
    @search_query = params[:q]

    @products = current_user.products.search(@search_query).order('id desc').page(params[:page]).per(2)
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
      flash[:alert] = "Para finalizar sua compra você 
      precisa estar logado no sistema."
      redirect_to new_user_session_path
    else
      if current_cart.line_items.count == 0
        flash[:alert] = "Seu carrinho de compras está vazio"
        redirect_to :back
      else
        order           = Order.new
        cart            = Cart.find(params[:id])
        #order          = Order.first
        #order          = Order.find(params[:id])
        #payment         = PagSeguro::PaymentRequest.new

        order.add_line_order_from_cart(cart)
        order.save
          

        payment = PagSeguro::PaymentRequest.new(email: 'doglasbatista@hotmail.com', token: '674953965F0B439DA05B70EF971F9E10')
          

        payment.reference         = order.id
        payment.notification_url  = "http://104.131.58.109:3000/notification"
        payment.redirect_url      = "http://104.131.58.109:3000/redirect"

        order.line_order.each do |product|
          payment.items << PagSeguro::Item.new({
            id: product.product.id,
            description: product.product.title,
            amount: product.product.price.to_f,
            weight: 0
            })
        end

        #payment.items = items
        response      = payment.register

        if response.errors.any?
          raise response.errors.join("\n")
        else
          redirect_to response.url
        end
      end
    end
  end
end
