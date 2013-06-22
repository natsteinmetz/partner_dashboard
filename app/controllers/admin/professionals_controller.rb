class Admin::ProfessionalsController < Admin::BaseController
  def index
    @professionals = Professional.includes(:partners).all
  end
end
