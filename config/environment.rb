# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PartnerDashboard::Application.initialize!

Date::DATE_FORMATS[:month_abrv_verbose] = "%b %d, %Y"
Date::DATE_FORMATS[:verbose] = "%B %d, %Y"