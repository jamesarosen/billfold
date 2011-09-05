require 'spec_helper'

describe Billfold::IdentitiesController do

  it 'routes /auth/:provider/callback to update_or_create' do
    { :post => '/auth/cheez/callback' }.
      should route_to(
        :controller => 'billfold/identities',
        :action => 'update_or_create',
        :provider => 'cheez'
      )
  end

end