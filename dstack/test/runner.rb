require 'minitest/autorun'
require_relative '../dstack.rb'
require_relative 'helper_handler_config.rb'
Dir[File.dirname(__FILE__) + '/test_*.rb'].sort.each { |file| require_relative file }
