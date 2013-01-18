require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroController" do
  before do
    @hero = Hero.named 'hero name'
    @hero.save
    get "/hero/#{@hero.id}"
  end

 it "should return the correct hero" do
   body = JSON.parse(last_response.body)
   assert_equal body['name'], @hero.name
 end

end
