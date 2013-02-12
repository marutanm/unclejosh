require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "HeroController" do
  let(:user) { Fabricate(:user) }
  let(:header) { { 'HTTP_UID' => user.id } }

  describe "get /" do
    let(:hero) { Fabricate(:hero) }
    before { get "/heros", { id: hero.id }, header }

    it "should return the correct hero" do
      body = JSON.parse last_response.body
      assert_equal body['name'], hero.name
    end
  end

  describe "post /" do
    let(:name) { Faker::Name.name }

    describe "without header" do
      before { post "/heros", { name: name } }
      specify { last_response.status.must_equal 403 }
    end

    describe "with header" do
      before { post "/heros", { name: name }, header }

      it "return created hero" do
        body = JSON.parse last_response.body
        assert_equal body['name'], name
      end
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

describe "UserController" do
  describe "post /" do
    let(:name) { Faker::Name.name }

    describe "name uniqueness validation" do
      before do
        User.create name: name
        post "/users", { name: name }
      end
      subject { last_response }

      specify do
        subject.status.must_equal 503
        subject.body.must_equal 'user name duplicated'
      end
    end

    describe "create user" do
      before { post "/users", { name: name } }
      subject { JSON.parse last_response.body }

      specify do
        subject['id'].wont_be_nil
        subject['name'].must_equal name
      end
    end
  end

  describe "get /" do
    let(:user) { Fabricate(:user) }
    let(:header) { { 'uid' => user.id } }

    describe "show current user" do
      before { get "/users", nil, header }
      subject { JSON.parse last_response.body }

      specify do
        subject['id'].must_equal user.id.to_s
        subject['name'].must_equal user.name
      end
    end

    describe "show another user" do
      let(:another_user) { Fabricate(:user) }
      before { get "/users", { id: another_user.id }, header }
      subject { JSON.parse last_response.body }

      specify do
        subject['id'].must_equal another_user.id.to_s
        subject['name'].must_equal another_user.name
      end
    end
  end
end
