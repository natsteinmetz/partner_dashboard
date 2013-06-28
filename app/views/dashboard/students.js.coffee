#Load  Partial into students_container
$("#students_container").children().fadeOut()
$("#students_container").children().remove()
<% if @students.empty? %>
$("#students_container").append("<span>You aren't connected with any students yet.</span>")
<% else %>
$("#students_container").append("<%= j students_table %>")
<% end %>
