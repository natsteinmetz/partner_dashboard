class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  #TODO: Use ajax?
  #TODO: Add conditional to make sure a connection be requested twice
  def create
    if current_user.has_role? :professional
      Relationship.pending!(current_user.partner.id, params[:user_id])
      respond_to do |format|
        format.html {
          redirect_to students_path
        }
        format.js {
          render 'create_student'
        }
      end
    else
      #is student
      Relationship.pending!(params[:partner_id], current_user.id)
      respond_to do |format|
        format.html {
          redirect_to partner_path(Partner.find(params[:partner_id]))
        }
        format.js {
          render 'create_partner'
        }
      end
    end
  end

  #TODO: Add destroy relationship
end
