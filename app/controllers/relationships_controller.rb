class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  #TODO: Use ajax?
  #TODO: Add conditional to make sure a connection be requested twice
  def create
    Relationship.pending!(current_user.partner.id, params[:student_id])
    respond_to do |format|
      format.html {
        redirect_to students_path
      }
      format.js {
        render 'create'
      }
    end
  end

  #TODO: Add destroy relationship
end
