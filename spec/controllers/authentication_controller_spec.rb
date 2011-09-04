require 'spec_helper'

describe Billfold::AuthenticationController do

  it 'routes /auth/:provider/callback to update_or_create' do
    { :post => '/auth/cheez/callback' }.
      should route_to(
        :controller => 'billfold/authentication',
        :action => 'update_or_create',
        :provider => 'cheez'
      )
  end

end