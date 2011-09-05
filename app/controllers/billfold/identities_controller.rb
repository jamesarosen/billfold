module Billfold
  class IdentitiesController < ApplicationController

    before_filter :require_sign_in, :only => [ :index, :destroy ]

    respond_to :html, :json, :xml
    helper_method :identities, :identity

    def index
      respond_to do |format|
        format.html {}
        format.json { render :json => identities }
        format.xml  { render :xml  => identities }
      end
    end

    def update_or_create
      omniauth_hash = request.env['omniauth.auth'] || {}
      identity = Billfold.identity_class.update_or_create!({
        :provider => params[:provider],
        :value    => omniauth_hash['uid'],
        :data     => omniauth_hash['user_info'],
        :user     => current_user
      })
      self.current_user ||= identity.user
      respond_to do |format|
        format.html { redirect_to '/' }
        format.json { head 201 }
        format.xml  { head 201 }
      end
    end

    def destroy
      identity.destroy
      respond_to do |format|
        format.html { redirect_to :index }
        format.json { head 200 }
        format.xml  { head 200 }
      end
    end

    private

    def identities
      @identities ||= current_user.identities
    end

    def identity
      @identity ||= current_user.identities.find_by_id(params[:identity_id] || params[:id])
    end

  end
end
