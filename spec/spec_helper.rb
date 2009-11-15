$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "init.rb"
require "spec"
require "spec/autorun"
require "fileutils"

database_path = "#{Dir.pwd}/db/pasieka_test.sqlite3"

# Clear test database
FileUtils.rm(database_path)

DataMapper.setup(:test, "sqlite3://#{database_path}")
DataMapper.auto_upgrade! :test

# load test messages
TEST_MESSAGES = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'test_messages.yml')))
