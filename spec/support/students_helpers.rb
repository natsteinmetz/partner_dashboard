module StudentsHelpers
  def sign_in_and_visit_students_as(user)
    sign_in_as!(user)
    visit "/"
    click_link "Students"
  end
end

RSpec.configure do |c|
  c.include StudentsHelpers, :type => :feature
end
