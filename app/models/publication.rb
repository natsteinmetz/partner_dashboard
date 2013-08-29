class Publication < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :title, :publisher, :authors, :date, :url, :summary
end
