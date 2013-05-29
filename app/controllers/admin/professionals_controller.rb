class Admin::ProfessionalsController < Admin::BaseController
  def index
    #Should probably set this up to get all the professionals, not all the partners
    @partners = Partner.all
  end
end
