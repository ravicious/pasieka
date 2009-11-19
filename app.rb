%w(sinatra lib/init).each do |lib|
  require lib
end

### Kontrolery

get '/' do
  "Hello world!"
end
