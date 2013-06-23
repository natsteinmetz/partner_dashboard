#Insert partner into select field
$("#user_partner_id options:selected").removeAttr("selected")
$("#user_partner_id").append("<option selected='selected' value='<%= @partner.id %>'><%= @partner.name %></option>")

#TODO: Make a better sort, this has some bugs.
#Sort the select field
$("#user_partner_id").html($("#user_partner_id option").sort( (a, b)->
  a.text == b.text ? 0 : a.text < b.text ? -1 : 1
  )
)

#Remove the New partner form
$("#new_partner_form").fadeOut(()->
  $("#new_partner_form").children().remove()
  $("#add_professional_button").show()
  $("#invitation_form").fadeIn()
  )