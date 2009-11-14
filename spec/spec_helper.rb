$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "pasieka"
require "spec"
require "spec/autorun"

# load test messages
TEST_MESSAGES = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'test_messages.yml')))