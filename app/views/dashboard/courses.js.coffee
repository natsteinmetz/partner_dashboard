#Load  Partial into courses_container
$("#courses_container").children().fadeOut()
$("#courses_container").children().remove()

#$("#courses_container").append("Test").show()
$("#courses_container").append("<%= j render('courses') %>")