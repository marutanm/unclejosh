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
