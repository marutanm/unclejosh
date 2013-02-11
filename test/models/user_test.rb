require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Fabricate User" do
  let(:user) { Fabricate(:user) }
  specify do
    user.wont_be_nil
    user.name.must_be_kind_of String
  end
end

describe "User Model" do
  it 'can construct a new instance' do
    @user = User.new
    refute_nil @user
  end
end

describe "name" do
  let(:name) { Faker::Name.name }
  let(:user) { Fabricate(:user, :name => name) }
  let(:no_name_user) { Fabricate(:user, :name => nil) }
  let(:same_name_user) { Fabricate.build(:user, :name => name) }

  specify do
    user.name.must_equal name
    no_name_user.name.must_equal 'NONAME'
    proc { same_name_user.save! }.must_raise Mongoid::Errors::Validations
  end
end
