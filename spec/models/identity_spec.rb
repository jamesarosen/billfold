require 'spec_helper'

describe Identity do

  subject { Identity }

  describe '.update_or_create!' do

    let(:user)     { Factory(:user) }
    let(:identity) { Factory(:twitter_identity) }
    let(:uid)      { Factory.next(:uid) }
    let(:name)     { 'Patricia Leone' }
    let(:arguments) do
      { :provider => 'twitter', :value => Factory.next(:twitter_handle) }
    end

    context 'with a nil provider' do
      it 'raises an ArgumentError' do
        lambda {
          subject.update_or_create!(arguments.merge({ :provider => nil }))
        }.should raise_error(ArgumentError)
      end
    end

    context 'with a nil value' do
      it 'raises an ArgumentError' do
        lambda {
          subject.update_or_create!(arguments.merge({ :value => nil }))
        }.should raise_error(ArgumentError)
      end
    end

    context 'with provider "twitter"' do
      let(:arguments) {
        {
          :provider => 'twitter',
          :value    => uid,
          :user     => nil,
          :data     => { 'name' => name }
        }
      }

      context 'and a nil user' do
        it 'creates a user' do
          expect { subject.update_or_create!(arguments) }.to change { User.count }.by(1)
        end

        it "uses the display name from the identity" do
          id = subject.update_or_create!(arguments)
          id.user.name.should == id.name_for_user
        end
      end

      context 'and a previously-unused UID' do
        before(:each) do
          @result = subject.update_or_create!({
            :provider => 'twitter',
            :value    => uid,
            :user     => user,
            :data     => { 'name' => name }
          })
        end

        it 'returns a saved Identity' do
          @result.should be_a(Identity)
          @result.should_not be_new_record
        end

        it 'uses the correct provider' do
          @result.provider.should == 'twitter'
        end

        it 'uses the correct value' do
          @result.value.should == uid
        end

        it 'passes the "user_info" as data' do
          @result.data['name'].should == name
        end

        it 'adds the identity to the user' do
          @result.user.should == user
        end
      end

      context 'and a UID previously used by the user' do
        before(:each) do
          @result = subject.update_or_create!({
            :provider => 'twitter',
            :value    => identity.value,
            :user     => identity.user,
            :data     => { 'name' => 'new name' }
          })
        end

        it 'updates the identity' do
          identity.reload.data['name'].should == 'new name'
        end
      end

      context 'and a UID previously used by another user' do
        let(:other_user) { Factory(:user) }

        before(:each) do
          @original_user = identity.user
          @original_user.should_not equal(other_user)
        end

        it 'merges the identity owner into the given user' do
          Identity.expects(:with_provider_and_value).returns(identity)
          @original_user.expects(:merge_into!).with(other_user)
          subject.update_or_create!({
            :provider => 'twitter',
            :value    => identity.value,
            :user     => other_user
          })
        end
      end
    end

  end

end
