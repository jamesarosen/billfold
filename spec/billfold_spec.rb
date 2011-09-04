require 'spec_helper'

describe Billfold do

  subject { Identity }

  describe '.user_class' do

    it 'should be ::User by default' do
      Billfold.user_class.should == ::User
    end

  end

  describe '.identity_class' do

    it 'should be ::Identity by default' do
      Billfold.identity_class.should == ::Identity
    end

  end

end
