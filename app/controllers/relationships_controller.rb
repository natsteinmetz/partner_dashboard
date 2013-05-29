class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  #TODO: Use ajax?
  def create
    relationship = Relationship.new(status: "pending")

    student = Student.find(params[:student_id])
    relationship.student = student
    relationship.partner_id = current_user.partner_id
    relationship.save

    flash[:notice] = "You successfully requested contact with #{student.name}."
    redirect_to students_path
  end
end
