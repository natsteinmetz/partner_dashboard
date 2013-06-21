new_partner_form = "<%= j( render 'new_partner_form' ) %>"

#Hide Select Partner Form
$('#invitation_form').fadeOut(()->

  #Clear out new partner form, Insert New Partner Form
  $('#new_partner_form').children().remove()
  $('#new_partner_form').append(new_partner_form)
  $('#new_partner_form').show()
  #Bind the go back button
  $('#go_back_button').bind('click', (e)->
    $('#new_partner_form').children().remove()
    $('#invitation_form').fadeIn()
    )
  )



# #Handle Successful or unsuccessful Partner Creation
# #If statement ensures this ajax success handler is added to the document only once
# if $._data(document, "events").hasOwnProperty("ajaxSuccess") == false
#   $(document).ajaxSuccess( (event, xhr, settings)->
#     #This if statement checks that this ajax success came from the create_partner action
#     if /\/admin\/users\/invitation\/create_partner/.test(settings.url)
#       #Create a flash success message

#       #Reload Page:


#     )

# if $._data(document, "events").hasOwnProperty("ajaxError") == false
#   #Handle Unsuccessful Partner Creation
#   $(document).ajaxError( (event, xhr, settings)->
#     if /\/admin\/users\/invitation\/create_partner/.test(settings.url)
#       #Clear out new_partner_form


#     )