# load all gems
%w(restclient json).each do |gem|

  begin
    require gem
  rescue LoadError
    abort "** Please install #{gem}"
  end

end

# load all libs
%w(miodek pasieka).each do |lib|
  require "lib/pasieka/#{lib}"
end
