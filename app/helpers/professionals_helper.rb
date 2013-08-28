module ProfessionalsHelper
  def action_cell(professional)
    unless current_user.has_role? :admin
      if current_user.connected? professional
        "<button class='btn btn-success btn-disabled' id='connect_button_student[#{professional.id}]'>Connected</button>".html_safe
      elsif current_user.requested_connection? professional
        "<button class='btn disabled' id='connect_button_student[#{professional.id}]'>Pending</button>".html_safe
      else
        button_to("Connect",
               { controller: "relationships", action: "create", professional_id: professional.id },
               remote: true, class: "btn btn-primary", id: "connect_button_student[#{professional.id}]")
      end
    end
  end
end
