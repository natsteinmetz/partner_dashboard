class Education < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :school_name, :field, :start_date, :end_date, :degree

  def date_range
    if start_date && end_date.blank?
      start_date.to_s + " - current"
    elsif start_date && end_date
      start_date.to_s + " - " + end_date.to_s
    else
      ""
    end
  end
end
