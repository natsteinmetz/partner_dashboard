class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    current_user.add_omniauth_info(request.env["omniauth.auth"])
    if current_user.profile == nil
      current_user.profile = Profile.create
      current_user.profile.build_profile
      redirect_to_show_or_edit("edit")
    else
      current_user.profile.check_profile_timestamp(current_user)
      redirect_to_show_or_edit("show")
    end

  end

  def redirect_to_show_or_edit(action)
    if current_user.has_role? :professional
      if action == "edit"
        redirect_to edit_professional_path(current_user)
      else
        redirect_to professional_path(current_user)
      end
    elsif current_user.has_role? :student
      if action == "edit"
        redirect_to edit_student_path(current_user)
      else
        redirect_to student_path(current_user)
      end
    end
  end

  alias_method :linkedin, :all
end
