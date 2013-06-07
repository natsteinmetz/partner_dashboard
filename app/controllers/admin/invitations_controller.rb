class Admin::InvitationsController < Devise::InvitationsController
  def new
    binding.pry
    @partners = Partner.all
    super
  end
end
