PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

require 'simplecov'
SimpleCov.adapters.define 'coverage' do
  add_filter '/vendor/'
  add_filter '/config/'
  add_filter '/test/'
end
SimpleCov.start 'coverage'

require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../app/helpers.rb', __FILE__)
require 'database_cleaner'

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    ##
    # You can handle all padrino applications using instead:
    #   Padrino.application
    Unclejosh.tap { |app|  }
  end
end

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

