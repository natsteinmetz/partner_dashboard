# #Destroy everything
# resources = ["Employment", "Mentorship", "Relationship", "Partner", "User", "Professional", "Student"]

# resources.each do |resource|
#   Object.const_get(resource).destroy_all
# end

#Create an admin user
admin = User.create(email: "admin@codefellows.com", password: "password")
admin.confirm!
admin.update_attribute(:admin, true)
admin.get_invite_requests = true
admin.add_role "admin"
admin.save

#Create some partners


#Create Some Students



