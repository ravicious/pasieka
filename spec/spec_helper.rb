require "lib/init"
require "spec"
require "spec/autorun"
require "fileutils"

test_database_path = "#{Dir.pwd}/db/pasieka_test.sqlite3"

# Clear test database
FileUtils.rm(test_database_path) if File.exists? test_database_path

DataMapper.setup(:default, "sqlite3://#{test_database_path}")
DataMapper.auto_upgrade!

# load test messages
TEST_MESSAGES = YAML.load_file('spec/test_messages.yml')
