module ApplicationHelper
  def students_table
    """
    <table class='table index'>
      <thead>
        <tr>
          <th>
            For Hire
          </th>
          <th>
            Name
          </th>
          <th>
            Skills
          </th>
          <th>
            Courses
          </th>
          #{'<th>Status</th>' unless current_user.admin?}
        </tr>
      </thead>
      <tbody class='list'>
        #{render @students}
      </tbody>
    </table>
    """.html_safe
  end
end
