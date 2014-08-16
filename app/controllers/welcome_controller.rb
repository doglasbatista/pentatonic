class WelcomeController < ApplicationController
  def index
    @products = Product.take(5)
  end

  def aboutUs
  end
end
