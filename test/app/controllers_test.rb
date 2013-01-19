require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroController" do

  describe "get /" do
    before { get "/hero/#{hero.id}" }
    let(:hero) { Fabricate(:hero) }

    it "should return the correct hero" do
      body = JSON.parse last_response.body
      assert_equal body['name'], hero.name
    end
  end

  describe "post /" do
    let(:name) { Faker::Name.name }
    before { post "/hero", { name: name } }

    it "return created hero" do
      body = JSON.parse last_response.body
      assert_equal body['name'], name
    end
  end

end
