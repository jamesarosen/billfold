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

  end

end
