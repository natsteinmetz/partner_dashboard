class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  #TODO: Use ajax?
  #TODO: Add conditional to make sure a contact cannot be requestd twice
  def create
    Relationship.pending!(current_user.partner.id, params[:student_id])
    flash[:notice] = "You successfully requested contact with #{Student.find(params[:student_id]).name}."
    redirect_to students_path
  end

end
