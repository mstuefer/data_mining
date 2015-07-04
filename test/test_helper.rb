require 'simplecov'
SimpleCov.start
require 'data_mining'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
