class AdminMailer < ActionMailer::Base
  default from: "no-reply@#{ENV["HOSTNAME"]}"

  def invite_request(invite_request)
    @invite_request = invite_request
    subject_suffix = "would like to be added to Partner Dashboard."

    mail to: ENV["ADMIN_EMAIL"],
         subject: "#{@invite_request.first_name} #{@invite_request.last_name} from #{@invite_request.company} #{subject_suffix}"
  end
end
