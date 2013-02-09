# More info at https://github.com/guard/guard#readme
guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/(.*)_test\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_config\.rb|)    { "test" }
  watch(%r{^app/(.+)\.rb})            { |m| "test/app/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)\.rabl})    { |m| "test/app/controllers_test.rb" }
  watch(%r{^models/(.+)\.rb})         { |m| "test/models/#{m[1]}_test.rb" }
end
