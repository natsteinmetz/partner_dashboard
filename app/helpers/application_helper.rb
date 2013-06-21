module ApplicationHelper
  def get_params(uri)
    Rack::Utils.parse_query URI(uri).query
  end
end
