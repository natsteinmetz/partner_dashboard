$("#connection_alert").remove()
button = $("#connect_button_partner\\[<%= params[:partner_id] %>\\]")
button.fadeOut( ()->
  $(this).attr("class", "btn disabled")
  $(this).text("Pending")
  $(this).show()
  $(this).attr("value", "Pending")
  )

#Add flash message
partner_name = "<%= j Partner.find(params[:partner_id]).name %>"
alert = "<div id='connection_alert' class='alert alert-success' style='display: none'><span>You successfully requested connection with #{partner_name}.</span></div>"
$(".navbar.navbar-fixed-top").append(alert)
$("#connection_alert").slideDown()
setTimeout ->
  $("#connection_alert").slideUp( ->
    $("#connection_alert").remove()
    )
, 3000
