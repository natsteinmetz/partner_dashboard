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