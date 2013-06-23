new_professional_form = "<%= j render('new_professional_form') %>"

#Hide Select Partner Form
$('#invitation_form').fadeOut(()->

  #Clear out new professional form, Insert New professional Form
  $('#new_professional_form').children().remove()
  $('#new_professional_form').append(new_professional_form)
  $('#new_professional_form').show()
  #Bind the go back button
  $('#go_back_button').bind('click', (e)->
    $('#new_professional_form').children().remove()
    $('#invitation_form').fadeIn()
    )
  )