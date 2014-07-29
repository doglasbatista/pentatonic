class RegistrationsController < Devise::RegistrationsController
  def load_cities
   unless params[:state_id].blank?
     @state = State.find(params[:state_id])
     @cities = @state.cities.collect { |c| [c.name, c.id] }
     render :layout => false
   end
 end
  def new
    super
  end
  def create
    super
  end
  def update
    super
  end
end
