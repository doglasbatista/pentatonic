class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  helper_method :current_cart

  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:nickname, :name, :surname, :cpf, :rg, 
      :address, :description, :birth, :email, :password, :password_confirmation, :city_id)}
  end

  private 
  def current_cart 
   Cart.find(session[:cart_id]) 
  rescue ActiveRecord::RecordNotFound 
   cart = Cart.create
   session[:cart_id] = cart.id
   cart 
 end
end
