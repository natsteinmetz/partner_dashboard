#TODO: Break active record queries up into different scopes
class DashboardController < ApplicationController
  def dash
    #Load current courses
    @courses = Course.where(":todays_date >= start_date AND :todays_date <= end_date", {todays_date: Date.today})
    #Load connected students
    @students = current_user.partner.students.all(joins: :relationships, conditions: {"relationships.contact_allowed" => true})
  end

  def courses
    todays_date = Date.today
    if params[:scope] == "Current"
      @courses = Course.where(":todays_date >= start_date AND :todays_date <= end_date", {todays_date: todays_date})
    elsif params[:scope] == "Past"
      @courses = Course.where(":todays_date > end_date", {todays_date: todays_date})
    elsif params[:scope] == "Upcoming"
      @courses = Course.where(":todays_date < start_date", {todays_date: todays_date})
    else
      render :dash
    end
    render "courses"
  end

  def students
    if params[:scope] == "Connected"
      @students = current_user.partner.students.all(joins: :relationships, conditions: {"relationships.contact_allowed" => true})
    elsif params[:scope] == "Pending"
      @students = current_user.partner.students.all(joins: :relationships, conditions: {"relationships.contact_allowed" => false})
    else
      render :dash
    end
    render "students"
  end
end