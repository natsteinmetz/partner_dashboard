module ApplicationHelper
  def students_table
    """
    <table class='table index'>
      <thead>
        <tr>
          #{"<th>For Hire</th>" unless current_user.has_role? :student}
          <th>
            Name
          </th>
          <th>
            Skills
          </th>
          <th>
            Courses
          </th>
          #{"<th>Status</th>" if current_user.has_role? :professional }
        </tr>
      </thead>
      <tbody class='list'>
        #{render partial: "students/student", collection: @students}
      </tbody>
    </table>
    """.html_safe
  end
end
