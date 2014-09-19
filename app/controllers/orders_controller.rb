class OrdersController < ApplicationController
 
  before_action :require_authentication
  before_action :can_edit

  def require_authentication
    unless current_user
      redirect_to new_user_session_path, alert: 'Você precisa esta logado!'
    end
  end

  def can_edit
    if current_user != @order.user
      redirect_to root_path, alert: 'Permissão negada!'
    end
  end
end