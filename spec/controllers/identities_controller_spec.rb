require 'spec_helper'

describe Billfold::IdentitiesController do

  it 'routes GET /auth/:provider/callback to update_or_create' do
    { :get => '/auth/cheez/callback' }.
      should route_to(
        :controller => 'billfold/identities',
        :action => 'update_or_create',
        :provider => 'cheez'
      )
  end

  it 'routes POST /auth/:provider/callback to update_or_create' do
    { :post => '/auth/cheez/callback' }.
      should route_to(
        :controller => 'billfold/identities',
        :action => 'update_or_create',
        :provider => 'cheez'
      )
  end

  it 'routes /identities to index' do
    { :get => '/identities' }.
      should route_to(
        :controller => 'billfold/identities',
        :action => 'index'
      )
  end

  it 'routes /identities/:id to destroy' do
    { :delete => '/identities/12' }.
      should route_to(
        :controller => 'billfold/identities',
        :action => 'destroy',
        :id => '12'
      )
  end

end