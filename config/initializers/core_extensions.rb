class String
  #method strips out white spaces,
  def emailize
    gsub(/\W/, '').downcase
  end
end