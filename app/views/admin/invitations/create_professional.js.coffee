#TODO This read only attribute is not working.
#Make Email Read Only
$('#user_email').attr('readonly', 'readonly')

#Make Select Partner Read Only
$('#user_partner_id').attr('readonly', 'readonly')

#Remove Partner Listed? Link
$('#add_partner_link').remove()

#Remove Add Professional Button
$('#add_professional_button').remove()

$('#new_professional_form').fadeOut( (e)->


  #Show Invitation form
  $('#invitation_form').show()
  )