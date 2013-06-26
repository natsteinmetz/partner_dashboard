class DashboardController < ApplicationController
  def dash
    #Current Courses
    @courses = Course.where(":todays_date >= start_date AND :todays_date <= end_date", {todays_date: Date.today})
    @students= current_user.partner.includes(:relationships, :students).students.where()
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
      redirect_to :dash
    end
    render "courses"
  end

  def students
  end
end