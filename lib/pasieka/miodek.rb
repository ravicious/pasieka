class Miodek
  attr_accessor :user, :password

  def initialize
    @user = config['user']
    @password = config['password']

    @api = RestClient::Resource.new('http://api.blip.pl', :user => @user, :password => @password, :headers => { :blip_api => 0.2 })
  end

  def get_messages(offset = nil)
    JSON.parse(
      @api["users/drmiodek/updates?offset=#{offset}&limit=50"].get :accept => 'application/json'
    )
  end

  protected

  def config
    YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'config.yml')))
  end

end
