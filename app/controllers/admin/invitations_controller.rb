class Admin::InvitationsController < Devise::InvitationsController
  def new
    @partners = Partner.all
    super
  end
end
