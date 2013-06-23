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
      render "new_populated"
    else
      build_resource
      render "new"
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

  def new_professional
    #TODO, testing if there are params in the URL, there needs to be a cleaner way.
    if get_referer_params("invite_request[first_name]")
      #TODO, add phone number to invite request and new professional form
      @professional = Professional.new(name: get_referer_params("invite_request[first_name]").capitalize + " " +
                                                         get_referer_params("invite_request[last_name]").capitalize,
                                       email: get_referer_params("invite_request[email]"))
      @professional.employments.build(role: get_referer_params("invite_request[role]"),
                                      partner_id: params[:partner_id])
    else
      @employment = @partner.employments.build
      @professional = @partner.professionals.build
    end
  end

  def create_professional
    @professional = Professional.new(params[:professional])
    if @professional.save
      render "create_professional"
    else
      render "new_professional"
    end
  end

end
