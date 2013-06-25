parent_container = $("tr#relationship\\[<%= @relationship.id %>\\]")
parent_container.find("td a:contains('Connect')").fadeOut(()->
  $(this).remove()
  parent_container.find("td.status_label" ).children().remove()
  parent_container.find("td.status_label").append("<%= j render("status", locals: {contact_allowed: @relationship.contact_allowed?}) %>")
  )
