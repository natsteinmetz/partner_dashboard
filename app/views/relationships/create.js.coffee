$("#connection_alert").remove()
button = $("#connect_button_student\\[<%= params[:student_id] %>\\]")
button.fadeOut( ()->
  $(this).attr("class", "btn disabled")
  $(this).text("Pending")
  $(this).show()
  )

#Add flash message
student_name = "<%= j Student.find(params[:student_id]).name %>"
alert = "<div id='connection_alert' class='alert alert-success' style='display: none'><span>You successfully requested connection with #{student_name}.</span></div>"
$(".navbar.navbar-fixed-top").append(alert)
$("#connection_alert").slideDown()
setTimeout ->
  $("#connection_alert").slideUp( ->
    $("#connection_alert").remove()
    )
, 3000
