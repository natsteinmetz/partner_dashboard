$("#contact_alert").remove()
button = $("#contact_button_student\\[<%= params[:student_id] %>\\]")
button.fadeOut( ()->
  $(this).attr("class", "btn disabled")
  $(this).text("Pending")
  $(this).show()
  )

#Add flash message
student_name = "<%= j Student.find(params[:student_id]).name %>"
alert = "<div id='contact_alert' class='alert alert-success' style='display: none'><span>You successfully requested contact with #{student_name}.</span></div>"
$(".navbar.navbar-fixed-top").append(alert)
$("#contact_alert").slideDown()
setTimeout ->
  $("#contact_alert").slideUp( ->
    $("#contact_alert").remove()
    )
, 3000
