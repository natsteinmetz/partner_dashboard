class Admin::InvitationsController < Devise::InvitationsController
  def new
    if params[:invite_request]
      @invite_request = InviteRequest.new params[:invite_request]

      user_params = ActiveSupport::HashWithIndifferentAccess.new(
        email: @invite_request.email,
        partner_id: nil
        )

      if Partner.exists?(name: @invite_request.company)
        user_params.merge! partner_id: Partner.find_by_name(@invite_request.company).id
      end

      #TODO: create a filter method to strip out unwanted params
      # so I can avoid user_params nastiness above
      build_resource user_params
      render :new_populated
    else
      build_resource
      render :new
    end
  end

  def new_partner
    @partner = Partner.new(name: params[:partner_name])
    respond_to do |format|
      format.js
    end
  end

  def create_partner
    @partner = Partner.new(params[:partner])
    respond_to do |format|
      format.js {
        if @partner.save
          render "create_partner"
        else
          render "new_partner"
        end
      }
    end
  end

  # def create_partner
  #   @partner = Partner.new(params[:partner])
  #   if @partner.save
  #     flash[:notice] = "Partner: #{@partner.name} has been created"
  #   else
  #     flash[:alert] = "Partner Not Saved"
  #   end
  #   redirect_to request.referer
  # end
end
