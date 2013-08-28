namespace :db do
  desc "Fill database with sample data"
  #to populate your db use command  rake db:populate
  task populate: :environment do
    puts "Starting creation of sample data...this may take a while..."


    #create some "real" student users
    puts "Creating demo student email: student@codefellows.com with password: password"
    sean_user = User.create(email:"student@codefellows.com",
                            password: "password",
                            password_confirmation: "password")
    sean_user.confirm!
    sean_profile = Profile.create(first_name: "Sean",
                          last_name: "Irby",
                          phone_number: "206-794-9466",
                          skills: "Ruby, Rails, Javascript, SQL",
                          for_hire: true,
                          summary: Faker::Lorem.paragraphs(2).join,
                          github_link: "https://github.com/seanirby")
    sean_user.profile = sean_profile
    sean_user.save
    sean_user.add_role :student

    danielle_user = User.create(email:"danielle@tuckerlabs.com",
                            password: "password",
                            password_confirmation: "password")
    danielle_user.confirm!
    danielle_profile = Profile.create(first_name: "Danielle",
                          last_name: "Tucker",
                          phone_number: "206-222-2222",
                          skills: "Ruby, Rails, jQuery, Javascript, Java",
                          for_hire: true,
                          summary: Faker::Lorem.paragraphs(2).join,
                          github_link: "https://github.com/tuckerd",
                          linkedin_link: "http://www.linkedin.com/in/dqtucker")
    danielle_user.profile = danielle_profile
    danielle_user.save
    danielle_user.add_role :student

    nathalie_user = User.create(email:"nathalie.steinmetz@gmail.com",
                            password: "password",
                            password_confirmation: "password")
    nathalie_user.confirm!
    nathalie_profile = Profile.create(first_name: "Nathalie",
                          last_name: "Steinmetz",
                          phone_number: "206-777-7777",
                          skills: "Ruby, Rails, jQuery, Javascript, Java",
                          for_hire: true,
                          summary: Faker::Lorem.paragraphs(2).join,
                          github_link: "https://github.com/natsteinmetz",
                          linkedin_link: "http://www.linkedin.com/in/nathaliesteinmetz",
                          personal_website_link: "http://nathaliesteinmetz.net")
    nathalie_user.profile = nathalie_profile
    nathalie_user.save
    nathalie_user.add_role :student

    #Create some fake students
    possible_skills = ["C++", "Java", "Ruby", "Rails", "HTML5", "CSS3", "Javascript", "jQuery", "C", "OOP", "Backend Development", "Frontend Development", "Sysadmin", "iOS", "Android", "Go", "Python", "Haskell", "Ember.js", "Node.js", "Java", "Backbone.js", "Angular.js"]
    course_titles = ["iOS Development", "Rails Bootcamp", "Python Night Class", "Javascript Beginnings", "Erlang Reunited", "Data Structures 101"]
    course_topics = ["iOS", "Rails", "Python", "Javascript", "Erlang", "Fundamentals"]

    # create courses with students
    puts "Creating courses with students."
    student_ids = [] #used later for creating pending relationships
    5.times do |n|
      start_date = Date.today >> n
      end_date = start_date.next_month
      course = Course.create(title: course_titles[n],
                             topic: course_topics[n],
                             details: Faker::Lorem.paragraph,
                             start_date: start_date,
                             end_date: end_date)

      10.times do
        name = Faker::Name.first_name
        last = Faker::Name.last_name
        full = name + " " + last
        email = "#{full.emailize}@gmail.com"
        phone_number = Faker::PhoneNumber.phone_number
        #Find a better way to do this
        skills = []
        3.times {skills.push possible_skills.sample}
        skills.uniq!

        user = User.create(email: email,
                    password: "password",
                    password_confirmation: "password")
        user.confirm!

        user.profile = Profile.create(first_name: name,
                                last_name: last,
                                phone_number: phone_number,
                                skills: skills.join(", "),
                                for_hire: [true, false].sample,
                                summary: Faker::Lorem.paragraphs(2).join,
                                github_link: "https://github.com/#{name.emailize}")
        user.save
        user.add_role :student
        student_ids.push(user.id)
        course.users << user
      end
    end

    puts "Creating partner companies with professionals."
    #Create some partners and professionals
    possible_kinds = ["Startup", "BigCo", "Hiring Agency"]
    partner_ids = [] #used later for relationships
    10.times do |n|
      name = Faker::Company.name
      kind = possible_kinds.sample
      size = rand(500)
      website = "https://linkedin.com/#{name.emailize}"
      skills = []
      3.times {skills.push possible_skills.sample}
      skills.uniq!
      technologies = skills.join(", ")
      about = Faker::Lorem.paragraphs(3).join
      partner = Partner.create(name: name, kind: kind, website: website, size: size, technologies: technologies, about: about)
      partner_ids.push(partner.id)

      #create professionals in this company
      (1..rand(1..3)).to_a.each do |i|
        name = Faker::Name.first_name
        last = Faker::Name.last_name
        full = name + " " + last
        email = "#{name}@#{partner.name.emailize}.com"
        links = "https://github.com/#{name.emailize}"
        professional_user = User.create(email: email,
                    password: "password",
                    password_confirmation: "password")
        professional_user.confirm!
        professional_user.add_role :professional
        professional_user.partner = partner
        professional_profile = Profile.create(
                    first_name: name,
                    last_name: last,
                    phone_number: Faker::PhoneNumber.phone_number,
                    summary: Faker::Lorem.paragraphs(3).join,
                    github_link: links)
        professional_user.profile = professional_profile
        professional_user.save
      end
    end

    #Create a test professional
    puts "Creating a demo professional email: professional@codefellows.com with password: password"
    professional_user = User.create(email: "professional@codefellows.com",
                password: "password",
                password_confirmation: "password")
    professional_user.confirm!
    professional_user.add_role :professional
    professional_user.partner = Partner.all.first
    name = Faker::Name.first_name
    professional_profile = Profile.create(
                first_name: name,
                last_name: Faker::Name.last_name,
                phone_number: Faker::PhoneNumber.phone_number,
                summary: Faker::Lorem.paragraphs(3).join,
                github_link: "https://github.com/#{name}")
    professional_user.profile = professional_profile
    professional_user.save


    #Create some pending relationships
    puts "Creating some pending relationships"
    (1..10).each do |n|
      partner_id = partner_ids.sample
      student_id = student_ids.sample
      Relationship.create(partner_id: partner_id, user_id: student_id)
    end

    puts "All done!"
  end
end
