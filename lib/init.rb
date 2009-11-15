%w(datamapper pasieka).each do |lib|
  require File.dirname(__FILE__) + "/#{lib}.rb"
end
