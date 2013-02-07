require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Battle Model" do
  it 'can construct a new instance' do
    @battle = Battle.new
    refute_nil @battle
  end

  describe 'accessor' do
    subject do
      Fabricate(:battle) do
          after_create do |battle|
            10.times do
              battle.master_attacks << Fabricate.build(:turn)
              battle.challenger_attacks << Fabricate.build(:turn)
            end
          end
      end
    end

    specify do
      subject.master.wont_be_nil
      subject.challenger.wont_be_nil
      subject.winner.must_be_nil
      subject.master_attacks.count.must_equal 10
      subject.challenger_attacks.count.must_equal 10
    end
  end
end
