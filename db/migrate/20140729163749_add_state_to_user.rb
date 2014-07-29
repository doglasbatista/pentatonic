class AddStateToUser < ActiveRecord::Migration
  def change
    add_reference :users, :state, index: true
  end
end
