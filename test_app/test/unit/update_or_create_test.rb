require 'test_helper'

class UpdateOrCreateTest < ActiveSupport::TestCase

  def subject
    Identity
  end

  def valid_params
    { :provider => 'flizzex', :value => Factory.next(:uid) }
  end

  def with_no_value_raises_error
    assert_raises ArgumentError do
      subject.update_or_create!(valid_params.merge(:value => nil))
    end
  end

  def with_no_provider_raises_error
    assert_raises ArgumentError do
      subject.update_or_create!(valid_params.merge(:provider => nil))
    end
  end

  def with_nil_user_creates_one
    assert_difference 'User.count' do
      subject.update_or_create!(valid_params.merge(:user => nil))
    end
  end

  def with_nil_user_initializes_user_name
    id = subject.update_or_create!(valid_params)
    assert_equal id.name_for_user, id.user.name
  end

  def with_a_user_and_an_unused_uid_creates_a_new_identity
    params = valid_params(:user => nil)
    id = subject.update_or_create!(params)
    assert id.instance_of?(Identity)
    assert !id.new_record?
    assert_equal params[:value], identity.value
  end

  def with_a_user_and_an_unused_uid_adds_to_the_user
    user = Factory(:user)
    params = valid_params(:user => user)
    id = subject.update_or_create!(params)
    assert_equal user, id.user
  end

  def with_a_uid_used_by_the_user_updates_the_identity
    id = twitter_identity
    result = subject.update_or_create!({
      :provider => id.provider,
      :value    => id.value,
      :user     => id.user,
      :data     => { 'name' => 'a new name' }
    })
    assert_equal 'a new name', identity.reload.data['name']
  end

  def with_a_uid_used_by_another_user_merges_into_the_given_user
    identity = Factory(:identity)
    new_user = Factory(:user)
    assert_not_equal identity.user, new_user
    Identity.expects(:where).returns([ identity ])
    identity.user.expects(:merge_into!).with(new_user)
    subject.update_or_create!({
      :provider => 'twitter',
      :value => Factory.next(:uid),
      :user => new_user
    })
  end

end
