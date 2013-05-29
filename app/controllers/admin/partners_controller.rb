class Admin::PartnersController < Admin::BaseController
  def index
    @partners = Partners.all
  end

end
