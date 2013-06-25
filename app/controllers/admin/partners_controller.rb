class Admin::PartnersController < Admin::BaseController
  def index
    @partners = Partner.all
  end
end
