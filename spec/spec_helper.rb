require "lib/init"
require "spec"
require "spec/autorun"
require "fakeweb"
require "fileutils"

test_database_path = "#{Dir.pwd}/db/pasieka_test.sqlite3"

# Clear test database
FileUtils.rm(test_database_path) if File.exists? test_database_path

DataMapper.setup(:default, "sqlite3://#{test_database_path}")
DataMapper.auto_upgrade!

# load test messages
TEST_MESSAGES = YAML.load_file('spec/test_messages.yml')

# FakeWeb
fake_miodek = Miodek.new
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get, "http://#{fake_miodek.user}:#{fake_miodek.password}@api.blip.pl/users/drmiodek/updates?offset=0&limit=50", :body => TEST_MESSAGES.to_json, :content_type => "application/json")
