class Miodek
  attr_accessor :user, :password

  def initialize
    @user = ENV['BLIP_USER'] || config['user']
    @password = ENV['BLIP_PASSWORD'] || config['password']

    @api = RestClient::Resource.new('http://api.blip.pl', :user => @user, :password => @password, :headers => { :blip_api => 0.2 })
  end

  def get_messages(offset = nil)
    JSON.parse(
      @api["users/drmiodek/updates?offset=#{offset}&limit=50"].get :accept => 'application/json'
    )
  end

  protected

  def config
    YAML.load_file('lib/config/config.yml')
  end

end
