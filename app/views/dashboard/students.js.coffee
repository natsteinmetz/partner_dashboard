#Load  Partial into students_container
$("#students_container").children().fadeOut()
$("#students_container").children().remove()
$("#students_container").append("<%= j render('students') %>")