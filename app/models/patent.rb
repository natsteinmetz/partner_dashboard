class Patent < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :title, :summary, :date, :url, :inventors
end
