%w(sinatra lib/init haml).each do |lib|
  require lib
end

configure :production do
  BlipApi.start
end

### Kontrolery

get '/' do
  @typo_counters = TypoCounter.all(:order => [ :counter.desc ])

  haml :index
end
