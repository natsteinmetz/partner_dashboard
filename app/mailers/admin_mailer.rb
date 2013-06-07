class AdminMailer < ActionMailer::Base
  default from: "admin_mailer@partnerdashboard.com"

  def invite_request(potential_user)
    @potential_user = potential_user
    subject_suffix = "would like to be added to Partner Dashboard."

    mail to: ADMIN_EMAIL,
         subject: "#{@potential_user[:first_name]} #{@potential_user[:last_name]} from #{@potential_user[:company]} #{subject_suffix}"
  end
end
