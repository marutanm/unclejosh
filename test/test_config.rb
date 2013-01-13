PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../app/helpers.rb', __FILE__)

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    ##
    # You can handle all padrino applications using instead:
    #   Padrino.application
    Unclejosh.tap { |app|  }
  end
end
