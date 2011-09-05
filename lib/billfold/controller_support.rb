require 'billfold'

module Billfold

  # ## Billfold::ControllerSupport
  #
  # Gets mixed in to `ApplicationController` automatically.
  module ControllerSupport

    # ### Billfold::ControllerSupport#current_user
    #
    # Return the current user, if signed in.
    def current_user
      @current_user ||= ::Billfold::user_class.find_by_id(session[:user_id])
    end

    # ### Billfold::ControllerSupport#current_user=
    #
    # Set the signed-in user.
    def current_user=(user)
      session[:user_id] = user ? user.id : nil
      @current_user = user
    end

    # ### Billfold::ControllerSupport#require_sign_in
    #
    # A before filter that requires a user to be signed in. The default
    # implementation adds a flash message and redirects to /
    def require_sign_in
      unless current_user
        flash['info'] = 'Please sign in'
        redirect_to root_path
      end
    end

  end

end
