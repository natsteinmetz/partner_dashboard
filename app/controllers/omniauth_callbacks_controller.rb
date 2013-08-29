class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    current_user.add_omniauth_info(request.env["omniauth.auth"])
    current_user.profile.build_profile
    if current_user.has_role? :professional
      redirect_to professional_path(current_user)
    elsif current_user.has_role? :student
      redirect_to student_path(current_user)
    end
  end
  alias_method :linkedin, :all
end
