$("#connection_alert").remove()
button = $("#connect_button_student\\[<%= params[:user_id] %>\\]")
button.fadeOut( ()->
  $(this).attr("class", "btn disabled")
  $(this).text("Pending")
  $(this).show()
  $(this).attr("value", "Pending")
  )

#Add flash message
student_name = "<%= j User.find(params[:user_id]).profile.name %>"
alert = "<div id='connection_alert' class='alert alert-success' style='display: none'><span>You successfully requested connection with #{student_name}.</span></div>"
$(".navbar.navbar-fixed-top").append(alert)
$("#connection_alert").slideDown()
setTimeout ->
  $("#connection_alert").slideUp( ->
    $("#connection_alert").remove()
    )
, 3000
