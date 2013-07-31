namespace :db do
  desc "Fill database with sample data"
  #to populate your db:  rake db:populate
  task populate: :environment do

    #Create some "real" students
    Student.create(name: "Sean Irby",
                   email: "sean.t.irby@gmail.com",
                   phone_number: "206-794-9466",
                   skills: "Ruby, Rails, Javascript, SQL",
                   for_hire: true,
                   bio: Faker::Lorem.paragraphs(3).join,
                   links: "https://github.com/seanirby"
                  )
    Student.create(name: "James Adney",
                   email: "jfadney@gmail.com",
                   phone_number: "206-794-9466",
                   skills: "Ruby, Rails, Javascript, Go, Python, Django",
                   for_hire: true,
                   bio: Faker::Lorem.paragraphs(3).join,
                   links: "https://github.com/jamesadney"
                  )

    #Create some fake students
    possible_skills = ["C++", "Java", "Ruby", "Rails", "HTML5", "CSS3", "Javascript", "jQuery", "C", "OOP", "Backend Development", "Frontend Development", "Sysadmin",
                       "iOS", "Android", "Go", "Python", "Haskell", "Ember.js", "Node.js"]
    course_titles = ["iOS June 2013", "Rails August 2013", "Python September 2014", "Javascript January 2014", "Erlang March 2016"]
    course_topics = ["iOS", "Rails", "Python", "Javascript", "Erlang"]

    # create courses with students
    5.times do |n|
      start_date = Date.today >> n
      end_date = start_date.next_month
      course = Course.create(title: course_titles[n],
                             topic: course_topics[n],
                             details: Faker::Lorem.paragraph,
                             start_date: start_date,
                             end_date: end_date)

      10.times do
        name = Faker::Name.name
        email = "#{name.emailize}@gmail.com"
        phone_number = Faker::PhoneNumber.phone_number
        #Find a better way to do this
        skills = []
        3.times {skills.push possible_skills.sample}
        skills.uniq!
        course.students.create( name: name,
                                email: email,
                                phone_number: phone_number,
                                skills: skills.join(", "),
                                for_hire: [true, false].sample,
                                bio: Faker::Lorem.paragraphs(3).join,
                                links: "https://github.com/#{name.emailize}")
      end
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
        email = "#{name.emailize}@#{partner.name.emailize}.com"
        professional = Professional.new(name: name, phone_number: phone_number, email: email)
        professional.employments.build(role: "Hiring Manager",
                                       partner_id: partner.id)
        professional.save
      end
    end

    #Create some pending relationships
    (1..10).each do |n|
      Relationship.create(partner_id: Partner.find(n).id, student_id: Student.find(n).id)
    end

    #Create some users, should probably put this under partners and professionals
    example_user = User.create(email: "example@example.com",
                password: "password",
                password_confirmation: "password")

    example_user.confirm!
    example_user.partner = Partner.first
    example_user.save


  end
end
