require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Battle Model" do
  it 'can construct a new instance' do
    @battle = Battle.new
    refute_nil @battle
  end

  describe 'accessor' do
    subject { Fabricate.build(:battle) }
    specify do
      subject.master.wont_be_nil
      subject.challenger.wont_be_nil
      subject.winner.must_be_nil
    end
  end
end
