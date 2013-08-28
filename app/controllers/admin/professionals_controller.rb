class Admin::ProfessionalsController < Admin::BaseController
  def index
    @professionals = User.with_role(:professional)
  end
end
