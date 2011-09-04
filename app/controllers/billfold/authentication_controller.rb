module Billfold
  class AuthenticationController < ApplicationController

    respond_to :html, :json, :xml

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

  end
end
