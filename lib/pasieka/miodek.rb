class Miodek
  config = YAML.load_file('lib/config/config.yml')
  @@user = ENV['BLIP_USER'] || config['user']
  @@password = ENV['BLIP_PASSWORD'] || config['password']

  @@api = RestClient::Resource.new('http://api.blip.pl', :user => @@user, :password => @@password, :headers => { :blip_api => 0.2 })

  class << self

    def user
      @@user
    end

    def password
      @@password
    end

    def get_messages(offset = 0, since = nil)
      JSON.parse(
        if since
          @@api["users/drmiodek/updates/#{since}/since?limit=50"].get :accept => 'application/json'
        else
          @@api["users/drmiodek/updates?offset=#{offset}&limit=50"].get :accept => 'application/json'
        end
      )
    end

  end

end
