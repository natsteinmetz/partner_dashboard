namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    #Create some users, should probably put this under partners and professionals
    User.create(email: "example@example.com",
                password: "password",
                password_confirmation: "password").confirm!
    50.times do |n|
      email = "#{Faker::Name.name.sub(/\s/, '').downcase}@example.com"
      password = "password"
      User.create(email: email,
                  password: password,
                  password_confirmation: password).confirm!
    end

    #Create some students
    possible_skills = ["C++", "Java", "Ruby", "Rails", "HTML5", "CSS3", "Javascript", "jQuery", "C", "OOP", "Backend Development", "Frontend Development", "Sysadmin",
                       "iOS", "Android", "Go", "Python", "Haskell", "Ember.js", "Node.js"]
    50.times do |n|
      name = Faker::Name.name
      email = "#{name.sub(/\s/, '').downcase}@gmail.com"
      phone_number = Faker::PhoneNumber.phone_number
      #Find a better way to do this
      skills = possible_skills.sample + ', ' + possible_skills.sample + ', ' + possible_skills.sample
      Student.create(name: name,
                     email: email,
                     phone_number: phone_number,
                     skills: skills)
    end

    #Create some partners and professionals
    possible_kinds = ["Startup", "BigCo", "Hiring Agency"]
    25.times do |n|
      name = Faker::Company.name
      kind = possible_kinds.sample
      partner = Partner.create(name: name, kind: kind)
      (1..rand(2..5)).to_a.each do |i|
        name = Faker::Name.name
        phone_number = Faker::PhoneNumber.phone_number
        email = "#{name.sub(/\s/, '').downcase}@#{partner.name.sub(/\s/, '').downcase}.com"
        professional = Professional.create(name: name, phone_number: phone_number, email: email)
        partner.professionals << professional
      end
    end
  end
end