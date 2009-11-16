$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "init.rb"
require "spec"
require "spec/autorun"
require "fileutils"

test_database_path = "#{Dir.pwd}/db/pasieka_test.sqlite3"

# Clear test database
FileUtils.rm(test_database_path) if File.exists? test_database_path

DataMapper.setup(:default, "sqlite3://#{test_database_path}")
DataMapper.auto_upgrade!

# load test messages
TEST_MESSAGES = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'test_messages.yml')))
