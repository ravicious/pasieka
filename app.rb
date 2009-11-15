%w(sinatra lib/init).each do |lib|
  require lib
end

@miodek = Miodek.new
@pasieka = Pasieka.new

### Kontrolery

get '/' do
  "Hello world!"
end
