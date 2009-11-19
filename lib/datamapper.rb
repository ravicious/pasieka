%w(dm-core dm-validations dm-timestamps).each do |gem|

  begin
    require gem
  rescue LoadError
    abort "** Please install #{gem}"
  end

end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pasieka.sqlite3")

# load all models
%w(typo typocounter).each do |model|
  require "lib/models/#{model}"
end

DataMapper.auto_upgrade!
