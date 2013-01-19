require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroController" do

  describe "get /" do
    before do
      @hero = Hero.create_with_name 'hero name'
      get "/hero/#{@hero.id}"
    end

    it "should return the correct hero" do
      body = JSON.parse(last_response.body)
      assert_equal body['name'], @hero.name
    end
  end

  describe "post /" do
    before do
      @name = 'hero name'
      post "/hero", { name: @name }
    end

    it "return created hero" do
      body = JSON.parse(last_response.body)
      assert_equal body['name'], @name
    end
  end

end
