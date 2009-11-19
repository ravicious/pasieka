require "lib/init"
require "spec"
require "spec/autorun"
require "fakeweb"
require "fileutils"

DataMapper.setup(:default, "sqlite3::memory:")
DataMapper.auto_upgrade!

# load test messages
TEST_MESSAGES = YAML.load_file('spec/test_messages.yml')

# FakeWeb
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get, "http://#{Miodek.user}:#{Miodek.password}@api.blip.pl/users/drmiodek/updates?offset=0&limit=50", :body => TEST_MESSAGES.to_json, :content_type => "application/json")
