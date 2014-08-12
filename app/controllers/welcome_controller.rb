class WelcomeController < ApplicationController
  def index
    @products = Product.order(:category_id)
  end

  def aboutUs
  end
end
