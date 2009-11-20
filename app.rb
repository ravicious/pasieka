%w(sinatra lib/init haml).each do |lib|
  require lib
end

### Kontrolery

get '/' do
  @typo_counters = TypoCounter.all(:order => [ :counter.desc ])

  haml :index
end
