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

  describe 'turns()' do
    let(:battle) do
      Fabricate(:battle) do
          after_create do |battle|
            (1..10).each.with_index(1) do |i|
              battle.master_attacks << Fabricate.build(:turn, counter: i)
              battle.challenger_attacks << Fabricate.build(:turn, counter: i)
            end
          end
      end
    end
    subject { battle.turns }

    specify do
      subject.must_be_instance_of Array
      subject.length.must_equal 20
      subject.each_with_index do |e, i|
        if i % 2 == 0
          e.owner.must_equal 'master'
        else
          e.owner.must_equal 'challenger'
        end
      end
    end
  end
end
