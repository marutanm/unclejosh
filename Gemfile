source :rubygems

# on Heroku
# https://blog.heroku.com/archives/2012/5/9/multiple_ruby_version_support_on_heroku
ruby '1.9.3'

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'sass'
gem 'haml'
gem "mongoid"

# Test requirements
gem 'minitest', "~>2.6.0", :require => "minitest/autorun", :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"
gem 'guard-minitest', :require => false, :group => "test"
gem 'database_cleaner', :require => false, :group => "test"
gem "simplecov", :require => false, :group => "test"
gem "fabrication", :require => false, :group => "test"
gem "faker", :require => false

# Padrino Edge
gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

gem 'rabl'
gem 'oj'

gem 'pry-padrino'
