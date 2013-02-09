require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroController" do

  describe "get /" do
    before { get "/heros/#{hero.id}" }
    let(:hero) { Fabricate(:hero) }

    it "should return the correct hero" do
      body = JSON.parse last_response.body
      assert_equal body['name'], hero.name
    end
  end

  describe "post /" do
    let(:name) { Faker::Name.name }
    before { post "/heros", { name: name } }

    it "return created hero" do
      body = JSON.parse last_response.body
      assert_equal body['name'], name
    end
  end

end

describe "BattleController" do
  describe "get /" do
    let(:battle) do
      Fabricate(:battle) do
          after_create do |battle|
            10.times do
              battle.master_attacks << Fabricate.build(:turn)
              battle.challenger_attacks << Fabricate.build(:turn)
            end
          end
      end
    end
    before { get "/battles/#{battle.id}" }

    it "should return battle" do
      body = JSON.parse last_response.body
      body['id'].must_equal battle.id
      body['master']['name'].must_equal battle.master.name
      body['challenger']['name'].must_equal battle.challenger.name
      body['winner'].must_be_nil
      body['turns'].must_be_instance_of Array
    end
  end
end
