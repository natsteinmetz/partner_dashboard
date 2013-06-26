module StudentsHelper
  def action_cell(student)
    unless current_user.admin?
      if current_user.connected? student
        "<button class='btn btn-success btn-disabled'>Connected</button>".html_safe
      elsif current_user.has_contacted? student
        "<button class='btn disabled'>Pending</button>".html_safe
      else
        button_to("Contact",{ controller: "relationships",
                              action: "create",
                              student_id: student.id },
                              class: "btn btn-primary",
                              form_class: "contact-button").html_safe
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
