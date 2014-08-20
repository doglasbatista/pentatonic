class WelcomeController < ApplicationController
  def index
    @products = Product.take(5)
  end

  def aboutUs
  end
  def checkout
   unless current_user
     flash[:notice] = "Para finalizar sua compra você 
     precisa estar logado no sistema."
     redirect_to :back
   else
     
    
  end
end
end
