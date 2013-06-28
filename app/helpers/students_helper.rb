module StudentsHelper
  def action_cell(student)
    unless current_user.admin?
      if current_user.connected? student
        "<button class='btn btn-success btn-disabled' id='connect_button_stude t[#{student.id}]'>Connected</button>".html_safe
      elsif current_user.requested_connection? student
        "<button class='btn disabled' id='connect_button_student[#{student.id}]'>Pending</button>".html_safe
      else
        #TODO: This is using a "GET" request and it should be a "POST"
        link_to("Connect", {controller: "relationships",
                            action: "create",
                            student_id: student.id,
                            remote: true},
                            id: "connect_button_student[#{student.id}]",
                            class: "btn btn-primary").html_safe
      end
    end
  end

  def name_cell(student)
    if current_user.connected? student
      link_to(student.name, student_path(student)).html_safe
    else
      student.name
    end
  end
end
